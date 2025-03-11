#Crear usuario
$usuario = Read-Host "Nombre para el nuevo usuario"
$comprobar = Get-LocalUser $usuario -ErrorAction SilentlyContinue

    if ($comprobar) {
        Write-Host "Usuario '$usuario' Ya existe"
    } else {
        $password = Read-Host "Contraseña para el nuevo usuario" -AsSecureString
        New-LocalUser  $usuario -Password $password
        $creado = Get-LocalUser -Name $usuario  
        Write-host  $creado "ha sido creado"
    }