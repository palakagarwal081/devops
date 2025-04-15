# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
# WORKDIR /app
# EXPOSE 5020

# ENV ASPNETCORE_URLS=http://+:5020

# USER app
# FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# ARG configuration=Release
# WORKDIR /src
# COPY ["ProductService.csproj", "./"]
# RUN dotnet restore "ProductService.csproj"
# COPY . .
# WORKDIR "/src/."
# RUN dotnet build "ProductService.csproj" -c $configuration -o /app/build

# FROM build AS publish
# ARG configuration=Release
# RUN dotnet publish "ProductService.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "ProductService.dll"]

# Base image with runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Expose the same port the app listens on (we’ll use 5000)
EXPOSE 5000

# Make ASP.NET Core listen on all interfaces on port 5000
ENV ASPNETCORE_URLS=http://+:5000

# Don’t use USER app here unless you’ve configured it in the image (default 'app' user may not have permissions)
# USER app ❌ (remove this unless specifically needed)

# Build stage
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["ProductService.csproj", "./"]
RUN dotnet restore "ProductService.csproj"
COPY . .
RUN dotnet build "ProductService.csproj" -c $configuration -o /app/build

# Publish stage
FROM build AS publish
ARG configuration=Release
RUN dotnet publish "ProductService.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

# Final image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Start the app
ENTRYPOINT ["dotnet", "ProductService.dll"]
