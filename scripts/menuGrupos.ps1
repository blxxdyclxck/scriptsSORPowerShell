function MostrarMenu {
    Write-Host " " 
    Write-Host "Menú de grupos:"
    Write-Host "1. Listar grupos"
    Write-Host "2. Ver miembros de un grupo"
    Write-Host "3. Crear grupo (pide nombre grupo)"
    Write-Host "4. Eliminar grupo (pide nombre grupo)"
    Write-Host "5. Crea miembro de un grupo (pide grupo y usuario)"
    Write-Host "6. Elimina miembro de un grupo (pide grupo y usuario)"
    Write-Host "7. Salir"
}

function ListarGrupos {
    Write-Host " " 
    Write-Host "Estos son todos los grupos:"
    $grupos = Get-LocalGroup 
    Write-Host $grupos
}

function VerMiembrosGrupo {
    $grupo = Read-Host "Escribe el nombre del grupo para ver sus usuarios"
    $comprobar = Get-LocalGroup $grupo -ErrorAction SilentlyContinue

    if ($comprobar) {
        Write-Host "Miembros del grupo '$grupo':"
        $miembros = Get-LocalGroupMember -Group $grupo
        Write-Host $miembros
    } else {
        Write-Host "El grupo  no existe"
    }

    
}

function CrearGrupo {
    $nombreGrupo = Read-Host "Escribe el nombre del nuevo grupo"
    $comprobar = Get-LocalGroup $nombreGrupo -ErrorAction SilentlyContinue

    if ($comprobar) {
        Write-Host "El grupo '$grupo' ya existe"
    } else {
        New-LocalGroup  -Name $nombreGrupo
        Write-Host "El grupo '$nombreGrupo' ha sido creado"
    }

}

function EliminarGrupo {
    $nombreGrupo = Read-Host "Escribe el nombre del grupo que desea eliminar"
    $comprobar = Get-LocalGroup $nombreGrupo -ErrorAction SilentlyContinue
    
    if ($comprobar) {
        Remove-LocalGroup -Name $nombreGrupo -ErrorAction SilentlyContinue
        Write-Host "El grupo '$nombreGrupo' ha sido eliminado"
    } else {
        Write-Host "El grupo '$nombreGrupo' no existe"
    }

}

function CrearMiembroGrupo {
    $grupo = Read-Host "Escribe el nombre del grupo al que desea  añadir un usuario"
    $comprobar = Get-LocalGroup $grupo -ErrorAction SilentlyContinue
    
    if ($comprobar) {
        $usuario = Read-Host "Escribe el nombre del usuario que desea añadir al grupo"
        $comprobar = Get-LocalUser $usuario -ErrorAction SilentlyContinue

        if ($comprobar) {
            Add-LocalGroupMember -Group $grupo -Member $usuario
            Write-Host "Usuario $usuario añadido al grupo $grupo"
        } else {
            New-LocalUser  -Name $usuario -NoPassword 
            Write-Host "Usuario $usuario creado"
            Add-LocalGroupMember -Group $grupo -Member $usuario
            Write-Host "Usuario $usuario añadido al grupo '$grupo' exitosamente."
        }    
    } else {
        Write-Host "El grupo '$grupo' no existe"
    }

}

function EliminarMiembroGrupo {
    $grupo = Read-Host "Escribe el nombre del grupo del que desea eliminar un usuario"
    $comprobar = Get-LocalGroup $grupo -ErrorAction SilentlyContinue
    
    if ($comprobar) {
        $usuario = Read-Host "Escribe el nombre del usuario que desea eliminar del grupo"
        $comprobar = Get-LocalUser $usuario -ErrorAction SilentlyContinue

        if ($comprobar) {
            Remove-LocalGroupMember -Group $grupo -Member $usuario -ErrorAction SilentlyContinue
            Write-Host "Usuario '$usuario' eliminado del grupo '$grupo' exitosamente."
        } else {
            Write-Host "El usuario '$usuario' no existe."
        }    
    } else {
        Write-Host "El grupo '$grupo' no existe"
    }

    
    
}

do {
    MostrarMenu
    $opcion = Read-Host "Seleccione opción"

    switch ($opcion) {
        1 { ListarGrupos }
        2 { VerMiembrosGrupo }
        3 { CrearGrupo }
        4 { EliminarGrupo }
        5 { CrearMiembroGrupo }
        6 { EliminarMiembroGrupo }
        7 { break }
        default { Write-Host "Opción no válida. Por favor, seleccione una opción válida." }
    }
} while ($opcion -ne 7)
