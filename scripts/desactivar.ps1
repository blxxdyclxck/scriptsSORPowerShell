$usuario = Read-Host "Dame un usuario existente para desactivar"

# Comprobación si el usuario existe
$infoUsuario = Get-LocalUser $usuario -ErrorAction SilentlyContinue

if ($infoUsuario) {
    # Verificar si el usuario está desactivado
    if (-not $infoUsuario.Enabled) {
        Write-Host "El usuario '$usuario' ya está desactivado."
    } else {
        # Desactivar el usuario
        Disable-LocalUser -Name $usuario
        Write-Host "Se ha desactivado el usuario '$usuario'."
    }
} else {
    Write-Host "El usuario '$usuario' no existe."
}


