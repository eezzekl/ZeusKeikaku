USE [ZeusFinal]
GO

/****** Object:  StoredProcedure [dbo].[st_InsAlbum_]    Script Date: 19/06/2017 11:27:57 p.m. ******/
DROP PROCEDURE  [dbo].[st_InsAlbum_]
GO

/****** Object:  StoredProcedure [dbo].[st_InsAlbum_]    Script Date: 19/06/2017 11:27:57 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Edwin G>
-- Create date: <06-Feb-2016>
-- Description:	<Procedimiento que agrega o modifica un registro de la tabla Album>
-- [ecanul] 15/06/2017 Modified. 
-- =============================================
CREATE PROCEDURE [dbo].[st_InsAlbum_] 
	-- Add the parameters for the stored procedure here
@AlbumId int,
@Titulo varchar(200),
@Imagen varchar(500),
@FechaPublicacion date,
@Formato varchar(50),
@Contenido varchar(200),
@Precio decimal(12,2),
@Oferta decimal(12,2),
@LinkCompra varchar(300),
@Promocion varchar(600),
@PerfilId int,
@SubGeneroId int,
@Estatus bit,
@FechaRegistro DATE,
@UrlAlbum VARCHAR(400),
@UseAlbum BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		merge into Album as target
	USING (SELECT @AlbumId, @Titulo, @Imagen, @FechaPublicacion,@Formato,@Contenido,@Precio,@Oferta,
				  @LinkCompra,@Promocion,@PerfilId,@SubGeneroId,@Estatus,@FechaRegistro,@UrlAlbum,@UseAlbum)
	AS SOURCE (AlbumId, Titulo, Imagen, FechaPublicacion,Formato,Contenido,Precio,Oferta,
		       LinkCompra,Promocion,PerfilId,SubGeneroId,Estatus,FechaRegistro,UrlAlbumPrecargado,UsarAlbumPrecargado)
	ON (TARGET.AlbumId = SOURCE.AlbumId)
	WHEN MATCHED THEN 
	UPDATE SET Titulo = @Titulo, 
			   Imagen = @Imagen,
			   FechaPublicacion = @FechaPublicacion,
			   Formato = @Formato,
			   Contenido = @Contenido,
			   Precio=@Precio,
			   Oferta = @Oferta,
			   LinkCompra = @LinkCompra,
			   Promocion=@Promocion,
			   PerfilId=@PerfilId,
			   SubGeneroId = @SubGeneroId,
			   Estatus= @Estatus,
			   UrlAlbumPrecargado = @UrlAlbum,
			   UsarAlbumPrecargado = @UseAlbum
	WHEN NOT MATCHED THEN
	INSERT ( 
			Titulo,
			Imagen, 
			FechaPublicacion,
			Formato,
			Contenido,
			Precio,
			Oferta,
			LinkCompra,
			Promocion,
			PerfilId,
			SubGeneroId,
			Estatus,
			UrlAlbumPrecargado,
			UsarAlbumPrecargado,
			FechaRegistro
			) 
			VALUES 
			(
			SOURCE.Titulo,
			SOURCE.Imagen, 
			SOURCE.FechaPublicacion,
			SOURCE.Formato,
			SOURCE.Contenido,
			SOURCE.Precio,
			SOURCE.Oferta,
			SOURCE.LinkCompra,
			SOURCE.Promocion,
			SOURCE.PerfilId,
			SOURCE.SubGeneroId,
			SOURCE.Estatus,
			SOURCE.UrlAlbumPrecargado,
			SOURCE.UsarAlbumPrecargado,
			getdate()
			 );
END
GO


