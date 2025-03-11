function MostrarMenu {
    Write-Host " " 
    Write-Host "Menú de usuarios:"
    Write-Host "1. Listar usuarios"
    Write-Host "2. Crear usuarios (pide usuario y contraseña)"
    Write-Host "3. Eliminar usuarios (pide usuario)"
    Write-Host "4. Modificar usuarios (pide usuario y nuevo nombre)"
    Write-Host "5. Salir"
}

function ListarUsuarios {
    Write-Host "Estos son todos los usuarios:"
    $usuarios = Get-LocalUser 
    Write-Host $usuarios
}

function CrearUsuario {
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
    
}

function EliminarUsuario {
    $usuario = Read-Host "Nombre del usuario que quieres eliminar"
    $comprobar = Get-LocalUser $usuario -ErrorAction SilentlyContinue

    if ($comprobar) {
        Remove-LocalUser -Name $usuario -ErrorAction SilentlyContinue
        Write-Host "Usuario '$usuario' eliminado exitosamente."
    } else {
        Write-Host "El usuario '$usuario' no existe."
    }
        
}

function ModificarUsuario {
    $usuario = Read-Host "Nombre de usuario que se va a  modificar"
    $comprobar = Get-LocalUser $usuario -ErrorAction SilentlyContinue

    if ($comprobar) {
        $nuevoNombre = Read-Host "Escribe el nuevo nombre para el usuario '$usuario'"
        Rename-LocalUser -Name $usuario -NewName $nuevoNombre
        Write-Host "Usuario '$usuario' modificado a '$nuevoNombre' exitosamente."
    } else {
        Write-Host "Usuario '$usuario' no existe"
    }
    
}

do {
    MostrarMenu
    $opcion = Read-Host "Seleccione opción"

    switch ($opcion) {
        1 { ListarUsuarios }
        2 { CrearUsuario }
        3 { EliminarUsuario }
        4 { ModificarUsuario }
        5 { break }
        default { Write-Host "Opción no válida. Por favor, seleccione una opción válida." }
    }
} while ($opcion -ne 5)
