$usuario = Read-Host "Dame un usuario existente"


# Comprobación si el usuario existe
$comprobar = Get-LocalUser $usuario -ErrorAction SilentlyContinue

if ($comprobar) {
    $descripcion = Read-Host "Dame una descripción"
    Set-LocalUser $usuario -Description $descripcion
    Write-Host "Se ha establecido la descripción para el usuario '$usuario'."
} else {
    Write-Host "El usuario '$usuario' no existe."
}
