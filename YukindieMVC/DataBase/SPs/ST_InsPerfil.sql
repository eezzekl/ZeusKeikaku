/**
* Inserta o modifica un perfil.
* [ecanul] 22/05/2017 Created.
* [ecanul] 06/06/2017 Modified, agregados campos para el uso de redes sociales dentro del perfil 
**/
create procedure st_InsPerfil
@PerfilId int output,
@usuarioId int,
@rol bit,
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
@DescripcionCorta nvarchar(100),
@Facebook varchar(200),
@Twitter varchar(200),
@Instagram varchar(200),
@Youtube varchar(200),
@SoundCloud varchar(200),
@Web varchar(200)
as
BEGIN
set nocount on;
merge into Perfil as target 
using (select @PerfilId, @usuarioId, @rol ,@perfilTipo ,@Nombre ,@Foto ,@acercaDe,@telefono,@correo ,
	@direccion,	@horario ,	@Fundacion,@ciudadId ,	@Latitud ,	@Longitud,	@Presskit,@DescripcionCorta,
	@Facebook, @Twitter, @Instagram, @Youtube, @SoundCloud, @Web)
as Source ( PerfilId,UsuarioId,Rol,PerfilTipoId,Nombre,FotoPerfil,AcercaDe,Telefono,Correo,
	Direccion,Horario,Fundacion,CiudadId,Latitud,Longitud,Presskit,DescripcionCorta, 
	Facebook, Twitter, Instagram, Youtube, SoundCloud, Web)
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
		DescripcionCorta = @DescripcionCorta,
		Facebook = @Facebook,
		Twitter = @Twitter,
		Instagram = @Instagram,
		Youtube = @Youtube,
		SoundCloud = @SoundCloud,
		Web = @Web
When not matched then 
	Insert 	(UsuarioId,Rol,PerfilTipoId,Nombre,FotoPerfil,AcercaDe,Telefono,Correo,
		Direccion,Horario,Fundacion,CiudadId,Latitud,Longitud,Presskit,DescripcionCorta, Facebook,Twitter,Instagram,Youtube,SoundCloud,Web)
	Values (SOURCE.UsuarioId,SOURCE.Rol,SOURCE.PerfilTipoId,SOURCE.Nombre,SOURCE.FotoPerfil,SOURCE.AcercaDe,SOURCE.Telefono,SOURCE.Correo,
		SOURCE.Direccion,SOURCE.Horario,SOURCE.Fundacion,SOURCE.CiudadId,SOURCE.Latitud,SOURCE.Longitud,SOURCE.Presskit,SOURCE.DescripcionCorta,
		Source.Facebook,Source.Twitter,Source.Instagram,Source.Youtube,Source.SoundCloud,Source.Web);
	set @PerfilId = SCOPE_IDENTITY();
END
GO