Create DataBase ZeusFinal;
USE [ZeusFinal]
GO
/****** Object:  Table [dbo].[Album]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album](
	[AlbumId] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](200) NOT NULL,
	[Imagen] [varchar](100) NOT NULL,
	[FechaPublicacion] [date] NOT NULL,
	[Formato] [varchar](50) NULL,
	[Contenido] [varchar](400) NULL,
	[Precio] [decimal](12, 2) NOT NULL,
	[Oferta] [decimal](12, 2) NOT NULL,
	[LinkCompra] [varchar](300) NULL,
	[Promocion] [varchar](600) NULL,
	[PerfilId] [int] NOT NULL,
	[SubGeneroId] [int] NOT NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[UrlAlbumPrecargado] [varchar](400) NULL,
	[UsarAlbumPrecargado] [bit] NULL,
 CONSTRAINT [PK__Album__97B4BE376F08DAD8] PRIMARY KEY CLUSTERED 
(
	[AlbumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AlbumTag]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumTag](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TagId] [int] NULL,
	[AlbumId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cancion]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cancion](
	[CancionId] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](400) NOT NULL,
	[Duracion] [varchar](5) NOT NULL,
	[NumeroTrack] [int] NOT NULL,
	[RutaArchivo] [varchar](max) NOT NULL,
	[Tipo] [bit] NULL,
	[AlbumId] [int] NOT NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Reproducciones] [int] NULL,
	[Letra] [nvarchar](max) NULL,
 CONSTRAINT [PK__Cancion__EDA6B18F0885F681] PRIMARY KEY CLUSTERED 
(
	[CancionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ciudad]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudad](
	[CiudadId] [int] IDENTITY(1,1) NOT NULL,
	[EstadoId] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK__Ciudad__E826E770D43C244A] PRIMARY KEY CLUSTERED 
(
	[CiudadId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Estado]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estado](
	[EstadoId] [int] IDENTITY(1,1) NOT NULL,
	[PaisId] [int] NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK__Estado__FEF86B008A449D85] PRIMARY KEY CLUSTERED 
(
	[EstadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Evento]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Evento](
	[EventoId] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](200) NOT NULL,
	[Imagen] [varchar](100) NOT NULL,
	[FechaEvento] [datetime] NOT NULL,
	[Direccion] [varchar](150) NOT NULL,
	[Establecimiento] [varchar](150) NOT NULL,
	[PrecioRegular] [decimal](12, 2) NULL,
	[Promocion] [varchar](300) NULL,
	[Preventa] [decimal](12, 0) NULL,
	[EventoTipoId] [int] NULL,
	[CiudadId] [int] NULL,
	[Latitud] [varchar](100) NULL,
	[Longitud] [varchar](100) NULL,
	[LinkEventoFacebook] [varchar](200) NULL,
	[LinkComprarBoleto] [varchar](200) NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
	[PerfilId] [int] NOT NULL,
 CONSTRAINT [PK__Evento__1EEB59211AFFF6DE] PRIMARY KEY CLUSTERED 
(
	[EventoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventoPerfil]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventoPerfil](
	[EventoPerfilId] [int] IDENTITY(1,1) NOT NULL,
	[EventoId] [int] NULL,
	[PerfilId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventoPerfilId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventoTag]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventoTag](
	[EventoTagId] [int] IDENTITY(1,1) NOT NULL,
	[TagId] [int] NULL,
	[EventoId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventoTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventoTipo]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventoTipo](
	[EventoTipoId] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventoTipoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventoVideo]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventoVideo](
	[EventoVideoId] [int] IDENTITY(1,1) NOT NULL,
	[EventoId] [int] NOT NULL,
	[UrlVideo] [varchar](300) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EventoVideoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genero]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genero](
	[GeneroId] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK__Genero__A99D0248708A5999] PRIMARY KEY CLUSTERED 
(
	[GeneroId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LikeAlbum]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikeAlbum](
	[LikeAlbumId] [int] IDENTITY(1,1) NOT NULL,
	[PerfilId] [int] NULL,
	[AlbumId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[LikeAlbumId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LikeCancion]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikeCancion](
	[LikeCancionId] [int] IDENTITY(1,1) NOT NULL,
	[PerfilId] [int] NULL,
	[CancionId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[LikeCancionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LikeEvento]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikeEvento](
	[LikeEventoId] [int] IDENTITY(1,1) NOT NULL,
	[PerfilId] [int] NULL,
	[EventoId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[LikeEventoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LikePerfil]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LikePerfil](
	[LikePerfilId] [int] IDENTITY(1,1) NOT NULL,
	[PerfilId] [int] NULL,
	[PerfilLike] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[LikePerfilId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pais]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[PaisId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PaisId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patrocinio]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patrocinio](
	[PatrocinioId] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nchar](100) NULL,
	[Medio] [nchar](300) NULL,
	[FechaInicio] [date] NULL,
	[FechaFin] [date] NULL,
	[EspacioId] [int] NULL,
	[EstadoId] [int] NULL,
	[VentaTotal] [bit] NULL,
	[Precio] [decimal](10, 2) NULL,
	[Observaciones] [varchar](500) NULL,
	[TipoPatrocinio] [int] NULL,
	[UrlEvento] [nchar](100) NULL,
	[PerfilId] [int] NULL,
	[FechaRegistro] [datetime] NULL,
	[Estatus] [bit] NULL,
	[TipoArchivo] [varchar](50) NULL,
 CONSTRAINT [PK__Patrocin__55CBF436EED2FA9A] PRIMARY KEY CLUSTERED 
(
	[PatrocinioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Perfil]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfil](
	[PerfilId] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Rol] [bit] NULL,
	[PerfilTipoId] [int] NOT NULL,
	[Nombre] [varchar](300) NULL,
	[FotoPerfil] [varchar](500) NULL,
	[AcercaDe] [varchar](max) NULL,
	[Telefono] [varchar](25) NULL,
	[Correo] [varchar](30) NOT NULL,
	[Direccion] [varchar](300) NULL,
	[Horario] [varchar](100) NULL,
	[Fundacion] [date] NULL,
	[CiudadId] [int] NULL,
	[Latitud] [nchar](15) NULL,
	[Longitud] [nchar](15) NULL,
	[Presskit] [nvarchar](100) NULL,
	[DescripcionCorta] [nvarchar](100) NULL,
 CONSTRAINT [PK__Perfil__0C005B0612AF1416] PRIMARY KEY CLUSTERED 
(
	[PerfilId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PerfilSociales]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerfilSociales](
	[PerfilSocialId] [int] IDENTITY(1,1) NOT NULL,
	[RedSocial] [nchar](30) NULL,
	[Url] [nchar](100) NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
	[PerfilId] [int] NULL,
 CONSTRAINT [PK__PerfilSo__15FD87236454BD86] PRIMARY KEY CLUSTERED 
(
	[PerfilSocialId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PerfilTipo]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerfilTipo](
	[PerfilTipoId] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Titulo] [nchar](15) NULL,
	[Imagen] [nchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PerfilTipoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seguridad.Menu]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seguridad.Menu](
	[MenuId] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](100) NOT NULL,
	[UrlMenu] [varchar](100) NOT NULL,
	[PadreId] [int] NULL,
	[Orden] [int] NULL,
	[EsPublico] [bit] NULL,
	[Icono] [varchar](20) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estatus] [bit] NOT NULL,
 CONSTRAINT [PK__Segurida__C99ED2304487185B] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seguridad.Rol]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seguridad.Rol](
	[RolId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](200) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Estatus] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RolId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Seguridad.RolPerfil]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seguridad.RolPerfil](
	[RolPerfilId] [int] IDENTITY(1,1) NOT NULL,
	[RolId] [int] NOT NULL,
	[PerfilId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RolPerfilId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubGenero]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubGenero](
	[SubGeneroId] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[GeneroId] [int] NOT NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK__SubGener__AF0A2E9957C94594] PRIMARY KEY CLUSTERED 
(
	[SubGeneroId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tag]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[TagId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipoPatrocinio]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoPatrocinio](
	[TipoPatId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nchar](30) NULL,
	[descripcion] [nchar](150) NULL,
	[FechaRegistro] [datetime] NULL,
	[Estatus] [bit] NULL,
 CONSTRAINT [PK__TipoPatr__89F975A687FF861E] PRIMARY KEY CLUSTERED 
(
	[TipoPatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 13/05/2017 07:12:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[UsuarioId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](70) NOT NULL,
	[Apellidos] [varchar](100) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[Sexo] [char](1) NOT NULL,
	[Telefono] [varchar](25) NULL,
	[Correo] [varchar](30) NOT NULL,
	[Contraseña] [varchar](30) NOT NULL,
	[Estatus] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Album] ON 

INSERT [dbo].[Album] ([AlbumId], [Titulo], [Imagen], [FechaPublicacion], [Formato], [Contenido], [Precio], [Oferta], [LinkCompra], [Promocion], [PerfilId], [SubGeneroId], [Estatus], [FechaRegistro], [UrlAlbumPrecargado], [UsarAlbumPrecargado]) VALUES (6, N'lo mejor de kush', N'/rutadeprueba/.jpg', CAST(N'2017-04-21' AS Date), N'CD', N'--', CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'www.google.com.mx', N'--', 3, 1, 1, CAST(N'2017-04-22T09:14:54.667' AS DateTime), NULL, NULL)
INSERT [dbo].[Album] ([AlbumId], [Titulo], [Imagen], [FechaPublicacion], [Formato], [Contenido], [Precio], [Oferta], [LinkCompra], [Promocion], [PerfilId], [SubGeneroId], [Estatus], [FechaRegistro], [UrlAlbumPrecargado], [UsarAlbumPrecargado]) VALUES (7, N'lo mejor de kush', N'/rutadeprueba/.jpg', CAST(N'2017-12-21' AS Date), N'CD', N'--', CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'www.google.com.mx', N'--', 3, 1, 1, CAST(N'2017-04-22T09:22:24.743' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Album] OFF
SET IDENTITY_INSERT [dbo].[AlbumTag] ON 

INSERT [dbo].[AlbumTag] ([id], [TagId], [AlbumId]) VALUES (1, 1, 6)
INSERT [dbo].[AlbumTag] ([id], [TagId], [AlbumId]) VALUES (3, 3, 6)
SET IDENTITY_INSERT [dbo].[AlbumTag] OFF
SET IDENTITY_INSERT [dbo].[Ciudad] ON 

INSERT [dbo].[Ciudad] ([CiudadId], [EstadoId], [Nombre], [Estatus], [FechaRegistro]) VALUES (2, 2, N'Cancún', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Ciudad] ([CiudadId], [EstadoId], [Nombre], [Estatus], [FechaRegistro]) VALUES (3, 1, N'Izamal', 1, CAST(N'2016-06-06T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Ciudad] OFF
SET IDENTITY_INSERT [dbo].[Estado] ON 

INSERT [dbo].[Estado] ([EstadoId], [PaisId], [Nombre], [Estatus], [FechaRegistro]) VALUES (1, 1, N'Yucatán', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Estado] ([EstadoId], [PaisId], [Nombre], [Estatus], [FechaRegistro]) VALUES (2, 1, N'Quintana Roo', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Estado] OFF
SET IDENTITY_INSERT [dbo].[Evento] ON 

INSERT [dbo].[Evento] ([EventoId], [Titulo], [Imagen], [FechaEvento], [Direccion], [Establecimiento], [PrecioRegular], [Promocion], [Preventa], [EventoTipoId], [CiudadId], [Latitud], [Longitud], [LinkEventoFacebook], [LinkComprarBoleto], [Estatus], [FechaRegistro], [PerfilId]) VALUES (34, N'segundo evento', N'/rutadeprueba/.jpg', CAST(N'2017-12-19T00:00:00.000' AS DateTime), N'calle 120', N'MATANZA', CAST(0.00 AS Decimal(12, 2)), N'', CAST(0 AS Decimal(12, 0)), 1, 3, N'', N'', N'', N'', 1, CAST(N'2017-05-12T22:33:24.620' AS DateTime), 3)
INSERT [dbo].[Evento] ([EventoId], [Titulo], [Imagen], [FechaEvento], [Direccion], [Establecimiento], [PrecioRegular], [Promocion], [Preventa], [EventoTipoId], [CiudadId], [Latitud], [Longitud], [LinkEventoFacebook], [LinkComprarBoleto], [Estatus], [FechaRegistro], [PerfilId]) VALUES (35, N'The Machine Gun Festival', N'capitanSoots.png', CAST(N'2017-05-19T00:00:00.000' AS DateTime), N'calle 120', N'MATANZA', CAST(0.00 AS Decimal(12, 2)), N'tu chica entra gratis', CAST(0 AS Decimal(12, 0)), 2, 3, N'', N'', N'wwww.google.com', NULL, 1, CAST(N'2017-05-13T08:59:49.763' AS DateTime), 3)
INSERT [dbo].[Evento] ([EventoId], [Titulo], [Imagen], [FechaEvento], [Direccion], [Establecimiento], [PrecioRegular], [Promocion], [Preventa], [EventoTipoId], [CiudadId], [Latitud], [Longitud], [LinkEventoFacebook], [LinkComprarBoleto], [Estatus], [FechaRegistro], [PerfilId]) VALUES (36, N'VLUR', N'music3.jpg', CAST(N'2017-05-26T00:00:00.000' AS DateTime), N'calle 120', N'MATANZA', CAST(0.00 AS Decimal(12, 2)), N'tu chica entra gratis', CAST(0 AS Decimal(12, 0)), 2, 3, N'', N'', N'www.facebook.com', NULL, 1, CAST(N'2017-05-13T09:06:24.363' AS DateTime), 3)
INSERT [dbo].[Evento] ([EventoId], [Titulo], [Imagen], [FechaEvento], [Direccion], [Establecimiento], [PrecioRegular], [Promocion], [Preventa], [EventoTipoId], [CiudadId], [Latitud], [Longitud], [LinkEventoFacebook], [LinkComprarBoleto], [Estatus], [FechaRegistro], [PerfilId]) VALUES (37, N'VLUR', N'music3.jpg', CAST(N'2017-12-26T00:00:00.000' AS DateTime), N'calle 120', N'MATANZA', CAST(0.00 AS Decimal(12, 2)), N'tu chica entra gratis', CAST(0 AS Decimal(12, 0)), 1, 3, N'', N'', N'www.facebook.com', N'www.tusboletos.com', 1, CAST(N'2017-05-13T09:25:59.327' AS DateTime), 3)
INSERT [dbo].[Evento] ([EventoId], [Titulo], [Imagen], [FechaEvento], [Direccion], [Establecimiento], [PrecioRegular], [Promocion], [Preventa], [EventoTipoId], [CiudadId], [Latitud], [Longitud], [LinkEventoFacebook], [LinkComprarBoleto], [Estatus], [FechaRegistro], [PerfilId]) VALUES (38, N'test 3', N'richard.jpg', CAST(N'2017-05-27T00:00:00.000' AS DateTime), N'calle 120', N'MATANZA', CAST(0.00 AS Decimal(12, 2)), N'test promo', CAST(0 AS Decimal(12, 0)), 1, 2, N'', N'', N'www.facebook.com', N'www.tusboletos.com', 1, CAST(N'2017-05-13T17:49:27.130' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[Evento] OFF
SET IDENTITY_INSERT [dbo].[EventoPerfil] ON 

INSERT [dbo].[EventoPerfil] ([EventoPerfilId], [EventoId], [PerfilId]) VALUES (60, 34, 5)
INSERT [dbo].[EventoPerfil] ([EventoPerfilId], [EventoId], [PerfilId]) VALUES (61, 35, 5)
INSERT [dbo].[EventoPerfil] ([EventoPerfilId], [EventoId], [PerfilId]) VALUES (62, 35, 6)
INSERT [dbo].[EventoPerfil] ([EventoPerfilId], [EventoId], [PerfilId]) VALUES (63, 36, 6)
INSERT [dbo].[EventoPerfil] ([EventoPerfilId], [EventoId], [PerfilId]) VALUES (72, 37, 6)
INSERT [dbo].[EventoPerfil] ([EventoPerfilId], [EventoId], [PerfilId]) VALUES (75, 38, 5)
SET IDENTITY_INSERT [dbo].[EventoPerfil] OFF
SET IDENTITY_INSERT [dbo].[EventoTag] ON 

INSERT [dbo].[EventoTag] ([EventoTagId], [TagId], [EventoId]) VALUES (82, 6, 34)
INSERT [dbo].[EventoTag] ([EventoTagId], [TagId], [EventoId]) VALUES (83, 3, 34)
INSERT [dbo].[EventoTag] ([EventoTagId], [TagId], [EventoId]) VALUES (84, 6, 35)
INSERT [dbo].[EventoTag] ([EventoTagId], [TagId], [EventoId]) VALUES (85, 6, 36)
INSERT [dbo].[EventoTag] ([EventoTagId], [TagId], [EventoId]) VALUES (94, 6, 37)
INSERT [dbo].[EventoTag] ([EventoTagId], [TagId], [EventoId]) VALUES (97, 3, 38)
SET IDENTITY_INSERT [dbo].[EventoTag] OFF
SET IDENTITY_INSERT [dbo].[EventoTipo] ON 

INSERT [dbo].[EventoTipo] ([EventoTipoId], [Descripcion], [Estatus], [FechaRegistro]) VALUES (1, N'Concierto', 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[EventoTipo] ([EventoTipoId], [Descripcion], [Estatus], [FechaRegistro]) VALUES (2, N'Caridad', 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[EventoTipo] ([EventoTipoId], [Descripcion], [Estatus], [FechaRegistro]) VALUES (3, N'Festival', 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[EventoTipo] OFF
SET IDENTITY_INSERT [dbo].[EventoVideo] ON 

INSERT [dbo].[EventoVideo] ([EventoVideoId], [EventoId], [UrlVideo]) VALUES (55, 34, N'ok')
INSERT [dbo].[EventoVideo] ([EventoVideoId], [EventoId], [UrlVideo]) VALUES (56, 34, N'test')
INSERT [dbo].[EventoVideo] ([EventoVideoId], [EventoId], [UrlVideo]) VALUES (57, 37, N'<iframe width="560" height="315" src="https://www.youtube.com/embed/qfFwECkLeMU" frameborder="0" allowfullscreen></iframe>')
INSERT [dbo].[EventoVideo] ([EventoVideoId], [EventoId], [UrlVideo]) VALUES (63, 38, N'https://www.youtube.com/watch?v=54EClt-_FyM')
INSERT [dbo].[EventoVideo] ([EventoVideoId], [EventoId], [UrlVideo]) VALUES (64, 38, N'modificado')
SET IDENTITY_INSERT [dbo].[EventoVideo] OFF
SET IDENTITY_INSERT [dbo].[Genero] ON 

INSERT [dbo].[Genero] ([GeneroId], [Descripcion], [Estatus], [FechaRegistro]) VALUES (1, N'Metal', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Genero] OFF
SET IDENTITY_INSERT [dbo].[Pais] ON 

INSERT [dbo].[Pais] ([PaisId], [Nombre], [Estatus], [FechaRegistro]) VALUES (1, N'México', 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Pais] OFF
SET IDENTITY_INSERT [dbo].[Perfil] ON 

INSERT [dbo].[Perfil] ([PerfilId], [UsuarioId], [Rol], [PerfilTipoId], [Nombre], [FotoPerfil], [AcercaDe], [Telefono], [Correo], [Direccion], [Horario], [Fundacion], [CiudadId], [Latitud], [Longitud], [Presskit], [DescripcionCorta]) VALUES (1, 1, 1, 1, N'Yukindie''s Musician Friends Club Band ', N'perfil.jpg', N'sin datos por el momeento', N'9991-12-23-20', N'ejgongorap@yukindie.com.mx', N'--', N'--', CAST(N'2017-01-01' AS Date), 2, N'--             ', N'--             ', N'--', N'Entrepeneur y Amante de la buena música')
INSERT [dbo].[Perfil] ([PerfilId], [UsuarioId], [Rol], [PerfilTipoId], [Nombre], [FotoPerfil], [AcercaDe], [Telefono], [Correo], [Direccion], [Horario], [Fundacion], [CiudadId], [Latitud], [Longitud], [Presskit], [DescripcionCorta]) VALUES (3, 1, 1, 3, N'Yukindie Concerts', N'perfil.jpg', N'División de YUKINDIE dedicada a la promoción y cobertura de conciertos en México', N'9991-23-34-21', N'concerts@yukindie.com.mx', N'--', N'--', CAST(N'2017-01-01' AS Date), 2, N'--             ', N'--             ', N'--', N'Conciertos para todos')
INSERT [dbo].[Perfil] ([PerfilId], [UsuarioId], [Rol], [PerfilTipoId], [Nombre], [FotoPerfil], [AcercaDe], [Telefono], [Correo], [Direccion], [Horario], [Fundacion], [CiudadId], [Latitud], [Longitud], [Presskit], [DescripcionCorta]) VALUES (4, 1, 1, 2, N'MATANZA', N'perfil.jpg', N'test', N'99992-23-34-23', N'test', N'--', N'--', CAST(N'2014-01-01' AS Date), 2, N'--             ', N'--             ', N'--', N'test')
INSERT [dbo].[Perfil] ([PerfilId], [UsuarioId], [Rol], [PerfilTipoId], [Nombre], [FotoPerfil], [AcercaDe], [Telefono], [Correo], [Direccion], [Horario], [Fundacion], [CiudadId], [Latitud], [Longitud], [Presskit], [DescripcionCorta]) VALUES (5, 1, 1, 2, N'Uberhate', N'perfil.jpg', N'test', N'9992-23-24-34', N'test', N'--', N'--', CAST(N'2017-01-01' AS Date), 2, N'--             ', N'--             ', N'--', N'test')
INSERT [dbo].[Perfil] ([PerfilId], [UsuarioId], [Rol], [PerfilTipoId], [Nombre], [FotoPerfil], [AcercaDe], [Telefono], [Correo], [Direccion], [Horario], [Fundacion], [CiudadId], [Latitud], [Longitud], [Presskit], [DescripcionCorta]) VALUES (6, 1, 1, 2, N'Vampiros Leyenda Urbana', N'perfil.jpg', N'test', N'9992-58-48-45', N'test', N'--', N'--', CAST(N'2016-01-01' AS Date), 2, N'--             ', N'--             ', N'--', N'test')
SET IDENTITY_INSERT [dbo].[Perfil] OFF
SET IDENTITY_INSERT [dbo].[PerfilTipo] ON 

INSERT [dbo].[PerfilTipo] ([PerfilTipoId], [Descripcion], [Estatus], [FechaRegistro], [Titulo], [Imagen]) VALUES (1, N'Fan', 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'Fan            ', N'fan.jpg                                           ')
INSERT [dbo].[PerfilTipo] ([PerfilTipoId], [Descripcion], [Estatus], [FechaRegistro], [Titulo], [Imagen]) VALUES (2, N'Músico', 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'Músico         ', N'musico.jpg                                        ')
INSERT [dbo].[PerfilTipo] ([PerfilTipoId], [Descripcion], [Estatus], [FechaRegistro], [Titulo], [Imagen]) VALUES (3, N'Promotor', 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'Promotor       ', N'promotor.jpg                                      ')
SET IDENTITY_INSERT [dbo].[PerfilTipo] OFF
SET IDENTITY_INSERT [dbo].[Seguridad.Menu] ON 

INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (1, N'Inicio', N'--', 0, 1, 1, N'fa fa-globe', CAST(N'2016-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (2, N'Música', N'--', 0, 2, 1, N'fa fa-music', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (4, N'Eventos', N'--', 0, 3, 1, N'fa fa-calendar', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (5, N'Mis Perfiles', N'javascript:;', 0, 4, 0, N'fa fa-users', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (6, N'Perfil 1', N'--', 5, 5, 0, N' ', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (7, N'Perfil 2', N'--', 5, 6, 0, N' ', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (8, N'Crear Nuevo', N'--', 5, 7, 0, N' ', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (9, N'Gestión de Información', N'javascript:;', 0, 8, 0, N'fa fa-cogs', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (10, N'Música', N'javascript:;', 9, 9, 0, N' ', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (11, N'Gestión de Álbumes', N'--', 10, 10, 0, N' ', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (12, N'Gestión de Canciones', N'--', 10, 11, 0, N' ', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Seguridad.Menu] ([MenuId], [Titulo], [UrlMenu], [PadreId], [Orden], [EsPublico], [Icono], [FechaRegistro], [Estatus]) VALUES (13, N'Eventos', N'--', 9, 12, 0, N' ', CAST(N'2017-01-01T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Seguridad.Menu] OFF
SET IDENTITY_INSERT [dbo].[SubGenero] ON 

INSERT [dbo].[SubGenero] ([SubGeneroId], [Descripcion], [GeneroId], [Estatus], [FechaRegistro]) VALUES (1, N'Nu Metal', 1, 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[SubGenero] OFF
SET IDENTITY_INSERT [dbo].[Tag] ON 

INSERT [dbo].[Tag] ([TagId], [Nombre], [Estatus], [FechaRegistro]) VALUES (1, N'#Rock', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Tag] ([TagId], [Nombre], [Estatus], [FechaRegistro]) VALUES (2, N'#UnidosPorLaMusica', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Tag] ([TagId], [Nombre], [Estatus], [FechaRegistro]) VALUES (3, N'#REDICOM', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Tag] ([TagId], [Nombre], [Estatus], [FechaRegistro]) VALUES (4, N'uber', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Tag] ([TagId], [Nombre], [Estatus], [FechaRegistro]) VALUES (5, N'#jotito', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Tag] ([TagId], [Nombre], [Estatus], [FechaRegistro]) VALUES (6, N'#repoio', 1, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Tag] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([UsuarioId], [Nombre], [Apellidos], [FechaNacimiento], [Sexo], [Telefono], [Correo], [Contraseña], [Estatus], [FechaRegistro]) VALUES (1, N'Edwin José', N'Góngora Pech', CAST(N'1991-03-24' AS Date), N'M', N'9991234356', N'edwing@gmail.com', N'12345', 1, CAST(N'2017-04-22T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Usuario] OFF
ALTER TABLE [dbo].[Cancion] ADD  CONSTRAINT [DF__Cancion__reprodu__276EDEB3]  DEFAULT ((0)) FOR [Reproducciones]
GO
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [FK__Album__PerfilId__4E88ABD4] FOREIGN KEY([PerfilId])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [FK__Album__PerfilId__4E88ABD4]
GO
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [FK__Album__SubGenero__4F7CD00D] FOREIGN KEY([SubGeneroId])
REFERENCES [dbo].[SubGenero] ([SubGeneroId])
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [FK__Album__SubGenero__4F7CD00D]
GO
ALTER TABLE [dbo].[AlbumTag]  WITH CHECK ADD  CONSTRAINT [FK__AlbumTag__AlbumI__5070F446] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[AlbumTag] CHECK CONSTRAINT [FK__AlbumTag__AlbumI__5070F446]
GO
ALTER TABLE [dbo].[AlbumTag]  WITH CHECK ADD FOREIGN KEY([TagId])
REFERENCES [dbo].[Tag] ([TagId])
GO
ALTER TABLE [dbo].[Cancion]  WITH CHECK ADD  CONSTRAINT [FK__Cancion__AlbumId__52593CB8] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[Cancion] CHECK CONSTRAINT [FK__Cancion__AlbumId__52593CB8]
GO
ALTER TABLE [dbo].[Ciudad]  WITH CHECK ADD  CONSTRAINT [FK__Ciudad__EstadoId__534D60F1] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[Estado] ([EstadoId])
GO
ALTER TABLE [dbo].[Ciudad] CHECK CONSTRAINT [FK__Ciudad__EstadoId__534D60F1]
GO
ALTER TABLE [dbo].[Estado]  WITH CHECK ADD  CONSTRAINT [FK__Estado__PaisId__5441852A] FOREIGN KEY([PaisId])
REFERENCES [dbo].[Pais] ([PaisId])
GO
ALTER TABLE [dbo].[Estado] CHECK CONSTRAINT [FK__Estado__PaisId__5441852A]
GO
ALTER TABLE [dbo].[Evento]  WITH CHECK ADD FOREIGN KEY([CiudadId])
REFERENCES [dbo].[Ciudad] ([CiudadId])
GO
ALTER TABLE [dbo].[Evento]  WITH CHECK ADD FOREIGN KEY([EventoTipoId])
REFERENCES [dbo].[EventoTipo] ([EventoTipoId])
GO
ALTER TABLE [dbo].[Evento]  WITH CHECK ADD FOREIGN KEY([PerfilId])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[EventoPerfil]  WITH CHECK ADD  CONSTRAINT [FK__EventoPer__Event__5535A963] FOREIGN KEY([EventoId])
REFERENCES [dbo].[Evento] ([EventoId])
GO
ALTER TABLE [dbo].[EventoPerfil] CHECK CONSTRAINT [FK__EventoPer__Event__5535A963]
GO
ALTER TABLE [dbo].[EventoPerfil]  WITH CHECK ADD FOREIGN KEY([PerfilId])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[EventoTag]  WITH CHECK ADD  CONSTRAINT [FK__EventoTag__Event__571DF1D5] FOREIGN KEY([EventoId])
REFERENCES [dbo].[Evento] ([EventoId])
GO
ALTER TABLE [dbo].[EventoTag] CHECK CONSTRAINT [FK__EventoTag__Event__571DF1D5]
GO
ALTER TABLE [dbo].[EventoTag]  WITH CHECK ADD FOREIGN KEY([TagId])
REFERENCES [dbo].[Tag] ([TagId])
GO
ALTER TABLE [dbo].[EventoVideo]  WITH CHECK ADD FOREIGN KEY([EventoId])
REFERENCES [dbo].[Evento] ([EventoId])
GO
ALTER TABLE [dbo].[LikeAlbum]  WITH CHECK ADD  CONSTRAINT [FK__LikeAlbum__Album__59063A47] FOREIGN KEY([AlbumId])
REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[LikeAlbum] CHECK CONSTRAINT [FK__LikeAlbum__Album__59063A47]
GO
ALTER TABLE [dbo].[LikeAlbum]  WITH CHECK ADD FOREIGN KEY([PerfilId])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[LikeCancion]  WITH CHECK ADD  CONSTRAINT [FK__LikeCanci__Canci__5AEE82B9] FOREIGN KEY([CancionId])
REFERENCES [dbo].[Cancion] ([CancionId])
GO
ALTER TABLE [dbo].[LikeCancion] CHECK CONSTRAINT [FK__LikeCanci__Canci__5AEE82B9]
GO
ALTER TABLE [dbo].[LikeCancion]  WITH CHECK ADD FOREIGN KEY([PerfilId])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[LikeEvento]  WITH CHECK ADD  CONSTRAINT [FK__LikeEvent__Event__5CD6CB2B] FOREIGN KEY([EventoId])
REFERENCES [dbo].[Evento] ([EventoId])
GO
ALTER TABLE [dbo].[LikeEvento] CHECK CONSTRAINT [FK__LikeEvent__Event__5CD6CB2B]
GO
ALTER TABLE [dbo].[LikeEvento]  WITH CHECK ADD FOREIGN KEY([PerfilId])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[LikePerfil]  WITH CHECK ADD FOREIGN KEY([PerfilId])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[LikePerfil]  WITH CHECK ADD FOREIGN KEY([PerfilLike])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[Patrocinio]  WITH CHECK ADD  CONSTRAINT [FK__Patrocini__Estad__60A75C0F] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[Estado] ([EstadoId])
GO
ALTER TABLE [dbo].[Patrocinio] CHECK CONSTRAINT [FK__Patrocini__Estad__60A75C0F]
GO
ALTER TABLE [dbo].[Patrocinio]  WITH CHECK ADD  CONSTRAINT [FK__Patrocini__TipoP__619B8048] FOREIGN KEY([TipoPatrocinio])
REFERENCES [dbo].[TipoPatrocinio] ([TipoPatId])
GO
ALTER TABLE [dbo].[Patrocinio] CHECK CONSTRAINT [FK__Patrocini__TipoP__619B8048]
GO
ALTER TABLE [dbo].[Perfil]  WITH CHECK ADD  CONSTRAINT [FK__Perfil__CiudadId__34C8D9D1] FOREIGN KEY([CiudadId])
REFERENCES [dbo].[Ciudad] ([CiudadId])
GO
ALTER TABLE [dbo].[Perfil] CHECK CONSTRAINT [FK__Perfil__CiudadId__34C8D9D1]
GO
ALTER TABLE [dbo].[Perfil]  WITH CHECK ADD  CONSTRAINT [FK__Perfil__PerfilTi__33D4B598] FOREIGN KEY([PerfilTipoId])
REFERENCES [dbo].[PerfilTipo] ([PerfilTipoId])
GO
ALTER TABLE [dbo].[Perfil] CHECK CONSTRAINT [FK__Perfil__PerfilTi__33D4B598]
GO
ALTER TABLE [dbo].[Perfil]  WITH CHECK ADD  CONSTRAINT [FK__Perfil__UsuarioI__32E0915F] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[Perfil] CHECK CONSTRAINT [FK__Perfil__UsuarioI__32E0915F]
GO
ALTER TABLE [dbo].[PerfilSociales]  WITH CHECK ADD  CONSTRAINT [FK__PerfilSoc__perfi__656C112C] FOREIGN KEY([PerfilId])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[PerfilSociales] CHECK CONSTRAINT [FK__PerfilSoc__perfi__656C112C]
GO
ALTER TABLE [dbo].[Seguridad.RolPerfil]  WITH CHECK ADD FOREIGN KEY([PerfilId])
REFERENCES [dbo].[Perfil] ([PerfilId])
GO
ALTER TABLE [dbo].[Seguridad.RolPerfil]  WITH CHECK ADD FOREIGN KEY([RolId])
REFERENCES [dbo].[Seguridad.Rol] ([RolId])
GO
ALTER TABLE [dbo].[SubGenero]  WITH CHECK ADD FOREIGN KEY([GeneroId])
REFERENCES [dbo].[Genero] ([GeneroId])
GO
/****** Object:  StoredProcedure [dbo].[st_DelAlbum_]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Edwin G>
-- Create date: <06-Feb-2016>
-- Description:	<Procedimiento que elimina un registro de la tabla Album>
-- =============================================
CREATE PROCEDURE [dbo].[st_DelAlbum_] 
	-- Add the parameters for the stored procedure here
@AlbumId int,
@PerfilId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		update Album set Estatus = 0 where AlbumId = @AlbumId and PerfilId = @PerfilId
END



GO
/****** Object:  StoredProcedure [dbo].[st_DelEventoPerfil]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Edwin G>
-- Create date: <01-May-2017>
-- Description:	<Procedimiento que elimina un registro de la tabla EventoPerfil>
-- =============================================
CREATE PROCEDURE [dbo].[st_DelEventoPerfil] 
	-- Add the parameters for the stored procedure here
@EventoId int,
@PerfilId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE EP
FROM EventoPerfil EP
INNER JOIN Evento E
  ON EP.EventoId=E.EventoId
WHERE EP.EventoId = @EventoId AND E.PerfilId = @PerfilId
END



GO
/****** Object:  StoredProcedure [dbo].[st_DelEventoTag]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Edwin G>
-- Create date: <01-May-2017>
-- Description:	<Procedimiento que elimina un registro de la tabla EventoTag>
-- =============================================
CREATE PROCEDURE [dbo].[st_DelEventoTag] 
	-- Add the parameters for the stored procedure here
@EventoId int,
@PerfilId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE ET
FROM EventoTag ET
INNER JOIN Evento E
  ON ET.EventoId=E.EventoId
WHERE ET.EventoId = @EventoId AND E.PerfilId = @PerfilId
END



GO
/****** Object:  StoredProcedure [dbo].[st_DelEventoVideo]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Edwin G>
-- Create date: <01-May-2017>
-- Description:	<Procedimiento que elimina un registro de la tabla EventoVideo>
-- =============================================
CREATE PROCEDURE [dbo].[st_DelEventoVideo] 
	-- Add the parameters for the stored procedure here
@EventoId int,
@PerfilId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE EV
FROM EventoVideo EV
INNER JOIN Evento E
  ON EV.EventoId=E.EventoId
WHERE EV.EventoId = @EventoId AND E.PerfilId = @PerfilId
END



GO
/****** Object:  StoredProcedure [dbo].[st_InsAlbum]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <01-Dic-2016>
-- Description:	<Procedimiento que inserta registros en la tabla Album>
-- =============================================
CREATE PROCEDURE [dbo].[st_InsAlbum]
	-- Add the parameters for the stored procedure here
	@Titulo varchar(200),
	@Imagen varchar(100),
	@FechaPublicacion date,
	@Formato varchar(50) ,
	@Contenido varchar(200) ,
	@Precio decimal(12,2) ,
	@Oferta decimal(12,2) ,
	@LinkCompra varchar(300) ,
	@Promocion varchar(600) ,
	@PerfilId int ,
	@SubGeneroId int ,
	@Estatus bit 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Album  (Titulo,
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
						FechaRegistro
						)
						values
						(
						@Titulo,
						@Imagen,
						@FechaPublicacion,
						@Formato,
						@Contenido,
						@Precio,
						@Oferta,
						@LinkCompra,
						@Promocion,
						@PerfilId,
						@SubGeneroId,
						@Estatus,
						getdate()
						);
END



GO
/****** Object:  StoredProcedure [dbo].[st_InsAlbum_]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Edwin G>
-- Create date: <06-Feb-2016>
-- Description:	<Procedimiento que agrega o modifica un registro de la tabla Album>
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
@FechaRegistro date

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		merge into Album as target
	USING (SELECT @AlbumId, @Titulo, @Imagen, @FechaPublicacion,@Formato,@Contenido,@Precio,@Oferta,
				  @LinkCompra,@Promocion,@PerfilId,@SubGeneroId,@Estatus,@FechaRegistro)
	AS SOURCE (AlbumId, Titulo, Imagen, FechaPublicacion,Formato,Contenido,Precio,Oferta,
		       LinkCompra,Promocion,PerfilId,SubGeneroId,Estatus,FechaRegistro)
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
			   Estatus= @Estatus
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
			getdate()
			 );
END



GO
/****** Object:  StoredProcedure [dbo].[st_InsCancion]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <23-Dic-2016>
-- Description:	<Procedimiento que inserta registros en la tabla cancion>
-- =============================================
CREATE PROCEDURE [dbo].[st_InsCancion] 
	-- Add the parameters for the stored procedure here
	@Titulo varchar(100),
	@Duracion varchar(5),
	@NumeroTrack int,
	@RutaArchivo varchar(max),
	@Tipo bit,
	@AlbumId int,
	@Estatus bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Cancion (Titulo,
						 Duracion,
						 NumeroTrack,
						 RutaArchivo,
						 Tipo,
						 AlbumId,
						 Estatus,
						 FechaRegistro
						)
						 VALUES
						(
						 @Titulo,
						 @Duracion,
						 @NumeroTrack,
						 @RutaArchivo,
						 @Tipo,
						 @AlbumId,
						 @Estatus,
						 getdate()
						);

END



GO
/****** Object:  StoredProcedure [dbo].[st_InsEvento]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <24-Abr-2017>
-- Description:	<Procedimiento que inserta o modifica registros en la tabla Evento y retorna un Id>
--NOTA: AGREGAR CAMPOS DE FECHA DE MODIFCACION.
-- =============================================
CREATE PROCEDURE [dbo].[st_InsEvento] 
	-- Add the parameters for the stored procedure here
@EventoId int output,
@Titulo varchar(200),
@Imagen varchar(100),
@FechaEvento Datetime,
@Direccion varchar(150),
@Establecimiento varchar(150),
@PrecioRegular decimal(12,2),
@Promocion varchar(300),
@Preventa decimal(12,2),
@EventoTipoId int,
@CiudadId int,
@Latitud varchar(100),
@Longitud varchar(100),
@LinkEventoFacebook varchar(200),
@LinkComprarBoleto varchar(200),
@Estatus bit,
@PerfilId int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	merge into Evento as target 
	using(select @EventoId,
	             @Titulo,
				 @Imagen,
				 @FechaEvento,
				 @Direccion,
				 @Establecimiento,
				 @PrecioRegular,
				 @Promocion,
				 @Preventa,
				 @EventoTipoId,
				 @CiudadId,
				 @Latitud,
				 @Longitud,
				 @LinkEventoFacebook,
				 @LinkComprarBoleto,
				 @Estatus,
				 @PerfilId
				 )
	as Source    (
				 EventoId,
	             Titulo,
				 Imagen,
				 FechaEvento,
				 Direccion,
				 Establecimiento,
				 PrecioRegular,
				 Promocion,
				 Preventa,
				 EventoTipoId,
				 CiudadId,
				 Latitud,
				 Longitud,
				 LinkEventoFacebook,
				 LinkComprarBoleto,
				 Estatus,
				 PerfilId
				 )
	on (target.EventoId = source.EventoId)
	when matched then
	update set   Titulo=@Titulo,
				 Imagen = @Imagen,
				 FechaEvento = @FechaEvento,
				 Direccion = @Direccion,
				 Establecimiento = @Establecimiento,
				 PrecioRegular = @PrecioRegular,
				 Promocion = @Promocion,
				 Preventa = @Preventa,
				 EventoTipoId = @EventoTipoId,
				 CiudadId = @CiudadId,
				 Latitud = @Latitud,
				 Longitud = @Longitud,
				 LinkEventoFacebook = @LinkEventoFacebook,
				 LinkComprarBoleto = @LinkComprarBoleto,
				 Estatus = @Estatus,
				 FechaRegistro = getdate(),
				 PerfilId = @PerfilId
	when not matched then
	insert (
	             Titulo,
				 Imagen,
				 FechaEvento,
				 Direccion,
				 Establecimiento,
				 PrecioRegular,
				 Promocion,
				 Preventa,
				 EventoTipoId,
				 CiudadId,
				 Latitud,
				 Longitud,
				 LinkEventoFacebook,
				 LinkComprarBoleto,
				 Estatus,
				 FechaRegistro,
				 PerfilId
				 ) 
				 values 
				 (
				 Source.Titulo,
				 Source.Imagen,
				 Source.FechaEvento,
				 Source.Direccion,
				 Source.Establecimiento,
				 Source.PrecioRegular,
				 Source.Promocion,
				 Source.Preventa,
				 Source.EventoTipoId,
				 Source.CiudadId,
				 Source.Latitud,
				 Source.Longitud,
				 Source.LinkEventoFacebook,
				 Source.LinkComprarBoleto,
				 Source.Estatus,
				 getdate(),
				 Source.PerfilId
				 );

				--SET @EventoId 

				set @EventoId = SCOPE_IDENTITY();
				 --select SCOPE_IDENTITY()
END

GO
/****** Object:  StoredProcedure [dbo].[st_InsEventoPerfil]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <24-Abr-2017>
-- Description:	<Procedimiento que inserta registros en la tabla intermedia EventoPerfil>
-- Update date: <30-Abr-2017>
-- Description: <Se cambio el paramentro @PerfilId por @Nombre por que eso recibimos en los tags
--				 asi que en base al nombre tomamos el Id>
-- =============================================
CREATE PROCEDURE [dbo].[st_InsEventoPerfil] 
	-- Add the parameters for the stored procedure here
@EventoId int,
@Nombre varchar(300)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @PerfilId int =0;

	set @PerfilId = (select PerfilId from Perfil where Nombre = @Nombre);

	if(@PerfilId <>0) 
		INSERT INTO EventoPerfil (EventoId,PerfilId) values (@EventoId,@PerfilId);

    -- Insert statements for procedure here

END

GO
/****** Object:  StoredProcedure [dbo].[st_InsEventoTag]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <24-Abr-2017>
-- Description:	<Procedimiento que inserta registros en la tabla intermedia EventoTag>
-- Update date: <30-Abr-2017>
-- Description: <Se cambio el paramentro @PerfilId por @Nombre por que eso recibimos en los tags
--				 asi que en base al nombre tomamos el Id>
-- =============================================
CREATE PROCEDURE [dbo].[st_InsEventoTag] 
	-- Add the parameters for the stored procedure here
@EventoId int,
@Nombre varchar(30) -- tag
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @TagId int =0;

	set @TagId = (select TagId from Tag where Nombre = @Nombre);

    -- Insert statements for procedure here
	INSERT INTO EventoTag (TagId,EventoId) values (@TagId,@EventoId);
END

GO
/****** Object:  StoredProcedure [dbo].[st_InsEventoTipo]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <24-Abr-2017>
-- Description:	<Procedimiento que inserta o modifica registros en la tabla EventoTipo
-- =============================================
create PROCEDURE [dbo].[st_InsEventoTipo] 
	-- Add the parameters for the stored procedure here
@EventoTipoId int,
@Descripcion varchar(100),
@Estatus bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	merge into EventoTipo as target 
	using(select @EventoTipoId,
				 @Descripcion,
				 @Estatus
				 )
	as Source    (
				 EventoTipoId,
				 Descripcion,
				 Estatus
				 )
	on (target.EventoTipoId = source.EventoTipoId)
	when matched then
	update set   Descripcion = @Descripcion,
				 Estatus = @Estatus,
				 FechaRegistro = getdate()
	when not matched then
	insert (
	             Descripcion,
				 Estatus,
				 FechaRegistro
				 ) 
				 values 
				 (
				 Source.Descripcion,
				 Source.Estatus,
				 getdate()
				 );

END

GO
/****** Object:  StoredProcedure [dbo].[st_InsEventoVideo]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <24-Abr-2017>
-- Description:	<Procedimiento que inserta registros en la tabla intermedia EventoVideo>
-- =============================================
create PROCEDURE [dbo].[st_InsEventoVideo] 
	-- Add the parameters for the stored procedure here
@EventoId int,
@UrlVideo varchar(300) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO EventoVideo (EventoId,UrlVideo) values (@EventoId,@UrlVideo);
END

GO
/****** Object:  StoredProcedure [dbo].[st_SelAlbum_]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Edwin Góngora>
-- Create date: <27-Noviembre-2016>
-- Description:	<Procedimiento que enlista todos los eventos para el modulo de listado de eventos filtrado por titulo>
-- =============================================
create PROCEDURE [dbo].[st_SelAlbum_]
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
		   s.Descripcion as SubGenero
		   from Album a
		   inner join Perfil p on a.PerfilId = p.PerfilId
		   inner join SubGenero s on a.SubGeneroId = s.SubGeneroId
	       --inner join eventoTipo et on e.EventoTipoId = et.EventoTipoId
		   where (a.AlbumId = @AlbumId or @AlbumId=0)
		   and (a.Titulo like '%'+ @Titulo + '%' or @Titulo is null)
	       and (a.PerfilId = @PerfilId or @PerfilId =0)
	       and a.Estatus = 1;
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelAlbumFiltro]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Edwin G>
-- Create date: <21-dic-2016>
-- Description:	<Procedimiento que enlista los albumes por medio de diferentes filtros>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelAlbumFiltro]
	-- Add the parameters for the stored procedure here
	@SubGeneroId int=null,
	@TipoOrdenamiento int=null
    /********Tipo Ordenamiento******/
	-- 1 Más Reciente, 2 Más Antiguo, 3 Más Popular, 4 A a la Z
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		if @SubGeneroId=0 
			set @SubGeneroId=null

		--	if @Precio=0 
		--set @Precio=null
    -- Insert statements for procedure here
	select a.AlbumId,
	       a.Titulo,
		   a.Imagen,
		   p.Nombre,
		   sg.Descripcion as SubGenero
		   from Album a
		   inner join Perfil p on a.PerfilId = p.PerfilId
	       inner join SubGenero sg on a.SubGeneroId = sg.SubGeneroId
	       where (sg.SubGeneroId = @SubGeneroId or @SubGeneroId is null)
	       and a.Estatus = 1
		   ORDER BY 
			CASE when @TipoOrdenamiento = 1 then a.FechaPublicacion end desc,
			CASE when @TipoOrdenamiento = 2 then a.FechaPublicacion end asc,
			--CASE when @TipoOrdenamiento = 3 then e.PrecioRegular end desc, --por ahora no esta esa métrica
			CASE when @TipoOrdenamiento = 4 then a.Titulo end asc
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelAlbumGet]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin Góngora>
-- Create date: <27-Noviembre-2016>
-- Description:	<Procedimiento que enlista todos los eventos para el modulo de listado de eventos filtrado por titulo>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelAlbumGet]
	-- Add the parameters for the stored procedure here
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
		   s.Descripcion as SubGenero
		   from Album a
		   inner join Perfil p on a.PerfilId = p.PerfilId
		   inner join SubGenero s on a.SubGeneroId = s.SubGeneroId
	       --inner join eventoTipo et on e.EventoTipoId = et.EventoTipoId
		   where a.Titulo like '%'+ @Titulo + '%'
	       and (a.PerfilId = @PerfilId or @PerfilId is null)
	       and a.Estatus = 1;
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelAlbumGetAll]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin Góngora>
-- Create date: <01-Dic-2016>
-- Description:	<Procedimiento que enlista todos los Albumes para el modulo de listado de Albumes>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelAlbumGetAll]
	-- Add the parameters for the stored procedure here
		@PerfilId int=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if @PerfilId=0 
		set @PerfilId=null
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
		   s.Descripcion as SubGenero
		   from Album a
		   inner join Perfil p on a.PerfilId = p.PerfilId
		   inner join SubGenero s on a.SubGeneroId = s.SubGeneroId
	       --inner join eventoTipo et on e.EventoTipoId = et.EventoTipoId
	       where (a.PerfilId = @PerfilId or @PerfilId is null)
	       and a.Estatus = 1;
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelAlbumGetOne]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin Góngora>
-- Create date: <01-Dic-2016>
-- Description:	<Procedimiento que obtiene un Album en base al id del Album y del usuario>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelAlbumGetOne]
	-- Add the parameters for the stored procedure here
	(
	@AlbumId as int,
	@PerfilId int
	)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if @PerfilId=0 
		set @PerfilId=null


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
		   p.Nombre as PerfilNombre,
		   s.Descripcion as SubGenero
		   from Album a 
		   inner join Perfil p on a.PerfilId = p.PerfilId
		   inner join SubGenero s on a.SubGeneroId = s.SubGeneroId
		   where a.AlbumId=@AlbumId 
		   and (a.PerfilId = @PerfilId or @PerfilId is null)
		   and a.Estatus = 1;
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelCancionGet]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <23-Dic-2016>
-- Description:	<Procedimiento que enlista todos los eventos para el modulo de listado de canciones filtrado por titulo>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelCancionGet]
	-- Add the parameters for the stored procedure here
	@Titulo varchar(100),
	@PerfilId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select c.CancionId,
		   c.Titulo,
		   c.Duracion,
		   c.NumeroTrack,
		   c.tipo,
		   a.Titulo as DescripcionAlbum
		   from Cancion c
		   inner join Album a on c.AlbumId = a.AlbumId
		   inner join Perfil p on a.PerfilId = p.PerfilId
	       --inner join eventoTipo et on e.EventoTipoId = et.EventoTipoId
		   where c.Titulo like '%'+ @Titulo + '%'
	       and (a.PerfilId = @PerfilId or @PerfilId is null)
	       and c.Estatus = 1;

END



GO
/****** Object:  StoredProcedure [dbo].[st_SelCancionGetAll]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <23-Dic-2016>
-- Description:	<Procedimiento que enlista todos los eventos para el modulo de listado de canciones filtrado por titulo>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelCancionGetAll]
	-- Add the parameters for the stored procedure here
	@PerfilId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		if @PerfilId=0 
		set @PerfilId=null

    -- Insert statements for procedure here
	select c.CancionId,
		   c.Titulo,
		   c.Duracion,
		   c.NumeroTrack,
		   c.Tipo,
		   a.Titulo as DescripcionAlbum,
		   c.Estatus
		   from Cancion c
		   inner join Album a on c.AlbumId = a.AlbumId
		   inner join Perfil p on a.PerfilId = p.PerfilId
	       --inner join eventoTipo et on e.EventoTipoId = et.EventoTipoId
		   where 
		   --c.Titulo like '%'+ @Titulo + '%'
	       --and 
		   (a.PerfilId = @PerfilId or @PerfilId is null)
	       and c.Estatus = 1;

END



GO
/****** Object:  StoredProcedure [dbo].[st_SelCancionGetOne]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <23-Dic-2016>
-- Description:	<Procedimiento que obtiene una cancion en base al id de la cancion y del usuario>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelCancionGetOne]
	-- Add the parameters for the stored procedure here
	@CancionId as int,
	@PerfilId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		if @PerfilId=0 
		set @PerfilId=null

    -- Insert statements for procedure here
	select c.CancionId,
		   c.Titulo,
		   c.Duracion,
		   c.NumeroTrack,
		   c.RutaArchivo,
		   c.Tipo,
		   c.AlbumId,
		   c.Estatus
		   from Cancion c
		   inner join Album a on c.AlbumId = a.AlbumId
		   inner join Perfil p on a.PerfilId = p.PerfilId
	       --inner join eventoTipo et on e.EventoTipoId = et.EventoTipoId
		   where 
		   c.CancionId = @CancionId
	       and 
		   (a.PerfilId = @PerfilId or @PerfilId is null)
	       and c.Estatus = 1;

END



GO
/****** Object:  StoredProcedure [dbo].[st_SelCiudadGetAll]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <27-Nov-2016>
-- Description:	<Procedimiento que enlista las ciudades activas>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelCiudadGetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 select CiudadId,
			Nombre 
			from Ciudad where Estatus=1
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelEvento]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin Góngora>
-- Create date: <07-Dic-2016>
-- Description:	<Procedimiento que enlista los eventos por medio de multiples filtros>
-- Create date: <24-Abr-2017>
-- Description:	<Se actualizo los datos de este SP a los nuevos campos que se estan trabajando>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelEvento]
	-- Add the parameters for the stored procedure here
		@EventoId int=0,
		@FechaInicial date = null,
		@FechaFinal date = null,
		@Precio decimal(12,2) = 0,
		@TipoOrdenamiento int=null,
		@Estatus bit = null
		/********Tipo Ordenamiento******/
		-- 1 Más Reciente, 2 Más Antiguo, 3 Mayor Precio, 4 Menor Precio, 5 Incluye promoción

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		--	if @Precio=0 
		--set @Precio=null
    -- Insert statements for procedure here
	select E.EventoId,
	       E.Titulo,
		   E.Imagen,
		   E.FechaEvento,
		   E.Direccion,
		   E.Establecimiento,
		   E.PrecioRegular,
		   E.Promocion,
		   E.Preventa,
		   E.EventoTipoId,
		   E.CiudadId,
		   E.Latitud,
		   E.Longitud,
		   E.LinkEventoFacebook,
		   E.LinkComprarBoleto,
		   E.Estatus,
		   E.PerfilId,
		   ET.Descripcion as TipoEvento
		   from evento E
		   --inner join Perfil p on e.PerfilId = p.PerfilId
	       inner join eventoTipo ET on e.EventoTipoId = et.EventoTipoId
	       where (e.EventoId = @EventoId or @EventoId =0)
		   and (e.FechaEvento >= @FechaInicial and e.FechaEvento <=@FechaFinal or @FechaInicial is null and @FechaFinal is null)
		   --and (e.PrecioRegular <= @Precio or @Precio is null)
	       and (E.Estatus = @Estatus or @Estatus is null)
		   ORDER BY 
			CASE when @TipoOrdenamiento = 1 then e.FechaEvento end desc,
			CASE when @TipoOrdenamiento = 2 then e.FechaEvento end asc,
			CASE when @TipoOrdenamiento = 3 then e.PrecioRegular end desc,
			CASE when @TipoOrdenamiento = 4 then e.PrecioRegular end asc,
			CASE when @TipoOrdenamiento = 5 then e.Promocion end desc
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelEventoPerfil]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <24-Abr-2017>
-- Description:	<Procedimiento que enlista los datos de la tabla EventoPerfil>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelEventoPerfil]
	-- Add the parameters for the stored procedure here
@EventoPerfilId int = 0,
@EventoId int =0,
@PerfilId int =0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT EP.EventoPerfilId,
		   EP.EventoId,
		   P.PerfilId,
		   P.Nombre  
		   FROM EventoPerfil EP
		   inner join Perfil P on EP.PerfilId = P.PerfilId
		   WHERE (EP.EventoPerfilId = @EventoPerfilId or @EventoPerfilId=0)
		   AND (EP.EventoId = @EventoId or @EventoId = 0)
		   AND (EP.PerfilId = @PerfilId or @PerfilId =0)
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelEventoTag]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <24-Abr-2017>
-- Description:	<Procedimiento que enlista los datos de la tabla EventoTag>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelEventoTag]
	-- Add the parameters for the stored procedure here
@EventoTagId int = 0,
@TagId int =0,
@EventoId int =0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ET.EventoTagId ,
		   ET.TagId ,
		   ET.EventoId,
		   T.Nombre   
		   FROM EventoTag ET
		   inner join Tag T on ET.TagId = T.TagId
		   WHERE (ET.EventoTagId = @EventoTagId or @EventoTagId=0)
		   AND (ET.TagId = @TagId or @TagId=0)
		   AND (ET.EventoId = @EventoId or @EventoId = 0)
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelEventoTipo]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <27-Nov-2016>
-- Description:	<Procedimiento que enlista los tipos de eventos activos>
-- Update date: <24-Abr-2017>
-- Description:	<Se agregaron parametros opcionales para que desde un mismo sp se puedan obtener un GetAll, GetOne y Get>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelEventoTipo]
	-- Add the parameters for the stored procedure here
@EventoTipoId int = 0,
@Descripcion varchar(100) = null,
@Estatus bit=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ET.EventoTipoId,
	       ET.Descripcion,
		   ET.Estatus
		   from EventoTipo ET
		   where (ET.EventoTipoId = @EventoTipoId OR @EventoTipoId = 0)
		   AND (ET.Descripcion LIKE '%' + @Descripcion  + '%' OR @Descripcion IS NULL)
		   AND (ET.Estatus = @Estatus OR @Estatus IS NULL)
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelEventoVideo]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <24-Abr-2017>
-- Description:	<Procedimiento que enlista los datos de la tabla EventoVideo>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelEventoVideo]
	-- Add the parameters for the stored procedure here
@EventoVideoId int = 0,
@EventoId int =0,
@UrlVideo varchar(300) =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT EV.EventoVideoId ,
		   EV.EventoId,
		   EV.UrlVideo  
		   FROM EventoVideo EV
		   WHERE (EV.EventoVideoId = @EventoVideoId or @EventoVideoId=0)
		   AND (EV.EventoId = @EventoId or @EventoId = 0)
		   AND (EV.UrlVideo = @UrlVideo or @UrlVideo is null)
END



GO
/****** Object:  StoredProcedure [dbo].[st_selPerfil]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Góngora>
-- Create date: <30-Abr-2017>
-- Description:	<Trae la Información de los perfiles>
-- =============================================
CREATE PROCEDURE [dbo].[st_selPerfil] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT PerfilId,Nombre from Perfil where PerfilTipoId=2
END

GO
/****** Object:  StoredProcedure [dbo].[st_SelSeguridadMenu]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin J. Gongora>
-- Create date: <14-Abr-2017>
-- Description:	<Procedimiento que trae los registros de la tabla [SEGURIDAD.MENU]>
-- Modificar con los paramentros correspondientes para la version en productivo
-- =============================================
CREATE PROCEDURE [dbo].[st_SelSeguridadMenu] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select MenuId,Titulo,UrlMenu,PadreId,Orden,EsPublico,FechaRegistro,Estatus from [Seguridad.Menu] where Estatus=1
END

GO
/****** Object:  StoredProcedure [dbo].[st_SelSubGeneroGetAll]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <02-Dic-2016>
-- Description:	<Procedimiento que enlista los subgeneros activos>
-- =============================================
create PROCEDURE [dbo].[st_SelSubGeneroGetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 select SubGeneroId,
			Descripcion 
			from Subgenero where Estatus=1
END



GO
/****** Object:  StoredProcedure [dbo].[st_SelTag]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <30-Abr-2016>
-- Description:	<Procedimiento que enlista los tags activos>
-- =============================================
CREATE PROCEDURE [dbo].[st_SelTag]
@TagId int=0,
@Nombre varchar(30)=NULL
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select TagId,Nombre,Estatus from Tag T
	where ( T.TagId = @TagId or @TagId = 0)
	AND (T.Nombre like '%' + @Nombre + '%' or @Nombre is null)
	AND T.Estatus = 1
END



GO
/****** Object:  StoredProcedure [dbo].[st_UpdAlbum]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <01-Dic-2016>
-- Description:	<Procedimiento que modifica registros en la tabla Album>
-- =============================================
CREATE PROCEDURE [dbo].[st_UpdAlbum]
	-- Add the parameters for the stored procedure here
	@AlbumId int,
	@Titulo varchar(200),
	@Imagen varchar(100),
	@FechaPublicacion date,
	@Formato varchar(50) ,
	@Contenido varchar(200) ,
	@Precio decimal(12,2) ,
	@Oferta decimal(12,2) ,
	@LinkCompra varchar(300) ,
	@Promocion varchar(600) ,
	@PerfilId int ,
	@SubGeneroId int ,
	@Estatus bit 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update Album set Titulo = @Titulo,
					  Imagen = @Imagen,
					  FechaPublicacion = @FechaPublicacion,
					  Formato = @Formato,
					  Contenido = @Contenido,
					  Precio = @Precio,
					  Oferta = @Oferta,
					  LinkCompra = @LinkCompra,
					  Promocion = @Promocion,
					  PerfilId = @PerfilId,
					  SubGeneroId = @SubGeneroId,
					  Estatus = @Estatus
					  where AlbumId = @AlbumId;
END



GO
/****** Object:  StoredProcedure [dbo].[st_UpdCancion]    Script Date: 13/05/2017 07:12:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Edwin G>
-- Create date: <23-Dic-2016>
-- Description:	<Procedimiento que modifica registros en la tabla cancion>
-- =============================================
CREATE PROCEDURE [dbo].[st_UpdCancion] 
	-- Add the parameters for the stored procedure here
	@CancionId int,
	@Titulo varchar(100),
	@Duracion varchar(5),
	@NumeroTrack int,
	@RutaArchivo varchar(max),
	@Tipo bit,
	@AlbumId int,
	@Estatus bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Cancion set   Titulo = @Titulo,
						 Duracion = @Duracion,
						 NumeroTrack = @NumeroTrack,
						 RutaArchivo = @RutaArchivo,
						 Tipo = @Tipo,
						 AlbumId = @AlbumId,
						 Estatus = @Estatus
						 WHERE CancionId = @Cancionid

END



GO
