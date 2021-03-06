USE [ZeusFinal]
GO
/****** Object:  StoredProcedure [dbo].[st_SelAlbum_]    Script Date: 03/07/2017 05:24:00 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Edwin Góngora>
-- Create date: <27-Noviembre-2016>
-- Description:	<Procedimiento que enlista todos los eventos para el modulo de listado de eventos filtrado por titulo>
-- =============================================
ALTER PROCEDURE [dbo].[st_SelAlbum_]
	-- Add the parameters for the stored procedure here
	@AlbumId int,
	@Titulo varchar(200),
	@PerfilId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select a.AlbumId,
		   a.Titulo,
		   a.Imagen,
		   a.FechaPublicacion,
		   a.Formato,
		   a.Contenido,
		   a.Precio,
		   a.Oferta,
		   a.LinkCompra,
		   a.Promocion,
		   a.PerfilId,
		   a.SubGeneroId,
		   a.Estatus,
		   s.Descripcion as SubGenero,
		   a.UsarAlbumPrecargado,
		   a.UrlAlbumPrecargado
		   from Album a
		   inner join Perfil p on a.PerfilId = p.PerfilId
		   inner join SubGenero s on a.SubGeneroId = s.SubGeneroId
	       --inner join eventoTipo et on e.EventoTipoId = et.EventoTipoId
		   where (a.AlbumId = @AlbumId or @AlbumId=0)
		   and (a.Titulo like '%'+ @Titulo + '%' or @Titulo is null)
	       and (a.PerfilId = @PerfilId or @PerfilId =0)
	       and a.Estatus = 1;
END



