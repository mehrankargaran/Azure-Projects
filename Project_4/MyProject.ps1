# -----------------------------
# MyProject.ps1
# -----------------------------

# Variables
$rgName     = "IT"
$location   = "eastasia"
$vnetName   = "VM-NET"
$vnetAddressSpace = "10.0.0.0/16"
$subnetAName = "subnetA"
$subnetAAddress = "10.0.0.0/24"
$subnetBName = "subnetB"
$subnetBAddress = "10.1.0.0/24"
$publicIpName = "vm001-pip"
$nsgName    = "SEC1"
$nicName    = "vm001-nic"
$vmName     = "vm001"
$vmSize     = "Standard_D2s_v3"
$adminUser  = Read-Host "Enter VM username"
$adminPassword = Read-Host "Enter VM password (must have 3 of: uppercase, lowercase, number, special)" -AsSecureString
$imagePublisher = "Canonical"
$imageOffer = "0001-com-ubuntu-server-jammy"
$imageSku   = "22_04-lts-gen2"

# 1. Create Resource Group
if (-not (Get-AzResourceGroup -Name $rgName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $rgName -Location $location
} else {
    Write-Host "Resource Group $rgName already exists."
}

# 2. Create Virtual Network with Subnets
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -ErrorAction SilentlyContinue
if (-not $vnet) {
    $subnetA = New-AzVirtualNetworkSubnetConfig -Name $subnetAName -AddressPrefix $subnetAAddress
    $subnetB = New-AzVirtualNetworkSubnetConfig -Name $subnetBName -AddressPrefix $subnetBAddress
    $vnet = New-AzVirtualNetwork -Name $vnetName -ResourceGroupName $rgName -Location $location -AddressPrefix $vnetAddressSpace -Subnet $subnetA,$subnetB
    Write-Host "Virtual Network $vnetName with subnets created."
} else {
    Write-Host "VNet $vnetName already exists."
}

# 3. Create Public IP
$pip = Get-AzPublicIpAddress -Name $publicIpName -ResourceGroupName $rgName -ErrorAction SilentlyContinue
if (-not $pip) {
    $pip = New-AzPublicIpAddress -Name $publicIpName -ResourceGroupName $rgName -Location $location -Sku Standard -AllocationMethod Static
    Write-Host "Public IP $publicIpName created."
} else {
    Write-Host "Public IP $publicIpName already exists."
}

# 4. Create NSG with inbound rule for port 80
$nsg = Get-AzNetworkSecurityGroup -Name $nsgName -ResourceGroupName $rgName -ErrorAction SilentlyContinue
if (-not $nsg) {
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName $rgName -Location $location -Name $nsgName
    $rule = New-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 -Access Allow
    $nsg | Add-AzNetworkSecurityRuleConfig -SecurityRule $rule | Set-AzNetworkSecurityGroup
    Write-Host "NSG $nsgName created with inbound rule port 80."
} else {
    Write-Host "NSG $nsgName already exists."
}

# 5. Create NIC in subnetA and associate NSG
$subnet = Get-AzVirtualNetworkSubnetConfig -Name $subnetAName -VirtualNetwork $vnet
$nic = New-AzNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $location -SubnetId $subnet.Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id
Write-Host "NIC $nicName created."

# 6. Configure VM
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize $vmSize
$vmConfig = Set-AzVMOperatingSystem -VM $vmConfig -Linux -ComputerName $vmName -Credential (New-Object System.Management.Automation.PSCredential($adminUser,$adminPassword)) -DisablePasswordAuthentication:$false
$vmConfig = Set-AzVMSourceImage -VM $vmConfig -PublisherName $imagePublisher -Offer $imageOffer -Skus $imageSku -Version "latest"
$vmConfig = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id

# 7. Create VM
New-AzVM -ResourceGroupName $rgName -Location $location -VM $vmConfig
Write-Host "VM $vmName created successfully."
