/**
* Inserta o modifica un perfil.
* [ecanul] 22/05/2017 Created.
**/
create procedure st_InsPerfil
@PerfilId int output,
@usuarioId int,
@rol int,
@perfilTipo int,
@Nombre varchar(300),
@Foto varchar(500),
@acercaDe varchar(MAX),
@telefono varchar(25),
@correo varchar(30),
@direccion varchar(300),
@horario varchar(100),
@Fundacion date,
@ciudadId int,
@Latitud nchar(15),
@Longitud nchar(15),
@Presskit varchar(100),
@DescripcionCorta nvarchar(100)
as
BEGIN
set nocount on;
merge into Perfil as target 
using (select @PerfilId, @usuarioId, @rol ,@perfilTipo ,@Nombre ,@Foto ,@acercaDe,@telefono,@correo ,
	@direccion,	@horario ,	@Fundacion,@ciudadId ,	@Latitud ,	@Longitud,	@Presskit,@DescripcionCorta)
as Source ( PerfilId,UsuarioId,Rol,PerfilTipoId,Nombre,FotoPerfil,AcercaDe,Telefono,Correo,
	Direccion,Horario,Fundacion,CiudadId,Latitud,Longitud,Presskit,DescripcionCorta	)
on (target.PerfilId = source.PerfilId)
when matched then
	update set Nombre = @Nombre, 
		FotoPerfil = @Foto,
		Telefono=@Telefono,
		Correo = @Correo,
		Direccion = @Direccion,
		Horario = @Horario,
		Fundacion = @Fundacion,
		CiudadId = @CiudadId,
		Latitud= @Latitud,
		Longitud = @Longitud,
		Presskit = @Presskit, 
		DescripcionCorta = @DescripcionCorta
When not matched then 
	Insert 	(UsuarioId,Rol,PerfilTipoId,Nombre,FotoPerfil,AcercaDe,Telefono,Correo,
		Direccion,Horario,Fundacion,CiudadId,Latitud,Longitud,Presskit,DescripcionCorta)
	Values (SOURCE.UsuarioId,SOURCE.Rol,SOURCE.PerfilTipoId,SOURCE.Nombre,SOURCE.FotoPerfil,SOURCE.AcercaDe,SOURCE.Telefono,SOURCE.Correo,
		SOURCE.Direccion,SOURCE.Horario,SOURCE.Fundacion,SOURCE.CiudadId,SOURCE.Latitud,SOURCE.Longitud,SOURCE.Presskit,SOURCE.DescripcionCorta);
	set @PerfilId = SCOPE_IDENTITY();
END
GO