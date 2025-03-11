#Crear usuario
$usuario = Read-Host "Nombre para el nuevo usuario"
$comprobar = Get-LocalUser $usuario -ErrorAction SilentlyContinue

if ($comprobar) {
    Write-Host "Usuario '$usuario' Ya existe"
} else {
    New-LocalUser -Name $usuario -NoPassword
    $creado = Get-LocalUser -Name $usuario  
    Write-host  $creado "ha sido creado"
}
