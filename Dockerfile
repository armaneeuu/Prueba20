# Usar la imagen base de ASP.NET Core
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Usar la imagen de SDK para construir el proyecto
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar el archivo del proyecto y restaurar las dependencias
COPY ["Prueba/Prueba.csproj", "Prueba/"]
RUN dotnet restore "Prueba/Prueba.csproj"

# Copiar todo el código fuente y compilar el proyecto
COPY . .
WORKDIR "/src/Prueba"
RUN dotnet build "Prueba.csproj" -c Release -o /app/build

# Publicar la aplicación
FROM build AS publish
RUN dotnet publish "Prueba.csproj" -c Release -o /app/publish

# Crear la imagen final
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Prueba.dll"]
