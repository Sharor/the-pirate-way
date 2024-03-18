# Building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder
LABEL image.author="David Johannes Christensen <david@cloudnation.dk>"
WORKDIR /app

COPY ./app .
RUN dotnet restore
RUN dotnet test
RUN dotnet publish -c Release -o output

# Runtime (leaner)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=builder /app/output .
ENTRYPOINT  ["dotnet", "pirate-way.dll"]