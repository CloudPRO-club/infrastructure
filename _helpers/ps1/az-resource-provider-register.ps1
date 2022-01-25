$tenantId =         ""
$subscriptionId =   ""

$account = Connect-AzAccount -Tenant $tenantId -SubscriptionId $subscriptionId -Scope Process
$context = Set-AzContext -Subscription $subscriptionId -Scope Process

$providers = Get-AzResourceProvider -ListAvailable | Where-Object -Property ProviderNamespace -Like "Microsoft.*"

for ($i = 0; $i -lt $providers.Count; $i++) {
    $provider = $providers[$i]
    $prefix = "$($i + 1) of $($providers.Count):"

    switch ($provider.RegistrationState) {
        "NotRegistered" {
            $registration = Register-AzResourceProvider -ProviderNamespace $provider.ProviderNamespace
            Write-Output "$($prefix) $($provider.ProviderNamespace) was $($provider.RegistrationState), now $($registration.RegistrationState)"
        }
        "Registering" {
            Write-Output "$($prefix) $($provider.ProviderNamespace) is $($provider.RegistrationState)"
        }
        "Registered" {
            Write-Output "$($prefix) $($provider.ProviderNamespace) is $($provider.RegistrationState)"
        }
        Default {
            Write-Error "$($prefix) $($provider.ProviderNamespace) is $($provider.RegistrationState)"
        }
    }
}