# Advent of Code 2023

This is a base repository to doing the advent of
code using .NET and Nix for package management.
I plan on using the dotnet-script global tool to
allow me to create scripts for each day.

When the Advent of Code has completed, I plan to
commit my solutions to this repository.

# Use
Use `nix develop` to get into a shell with the
tools required to develop .NET applications.

If you are using a .NET project, use you will
need a `deps.nix` file containing the hashes
for the NuGet packages your project needs.

`nix run -L .#fetch-deps ./deps.nix`

note: you may need to create an empty `deps.nix`
file for the above command to work.
