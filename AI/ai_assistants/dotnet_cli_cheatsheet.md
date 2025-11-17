# .NET CLI, NuGet Package Manager, Linting & Code Formatting Cheatsheet

---

## 🚀 .NET CLI Project Management

### Project Creation & Templates
```bash
# List available templates
dotnet new list

# Create new console application
dotnet new console -n MyConsoleApp

# Create new web API
dotnet new webapi -n MyWebApi

# Create new MVC web application
dotnet new mvc -n MyMvcApp

# Create new Blazor Server app
dotnet new blazorserver -n MyBlazorApp

# Create new class library
dotnet new classlib -n MyLibrary

# Create new solution file
dotnet new sln -n MySolution

# Create new xUnit test project
dotnet new xunit -n MyTests
```

### Solution & Project Management
```bash
# Add project to solution
dotnet sln add ./MyProject/MyProject.csproj

# Remove project from solution
dotnet sln remove ./MyProject/MyProject.csproj

# List projects in solution
dotnet sln list

# Add project reference
dotnet add reference ../MyLibrary/MyLibrary.csproj

# Remove project reference
dotnet remove reference ../MyLibrary/MyLibrary.csproj

# List project references
dotnet list reference
```

### Build, Run & Test
```bash
# Restore dependencies
dotnet restore

# Build project/solution
dotnet build

# Build in Release mode
dotnet build --configuration Release

# Run application
dotnet run

# Run with specific project file
dotnet run --project ./MyProject/MyProject.csproj

# Run tests
dotnet test

# Run tests with coverage
dotnet test --collect:"XPlat Code Coverage"

# Run tests in specific project
dotnet test ./MyTests/MyTests.csproj

# Watch and auto-rebuild on file changes
dotnet watch run

# Watch and auto-run tests
dotnet watch test
```

### Publishing & Deployment
```bash
# Publish application
dotnet publish

# Publish for specific runtime
dotnet publish -r win-x64

# Publish as single file
dotnet publish -r win-x64 --self-contained -p:PublishSingleFile=true

# Publish with trimming (reduce size)
dotnet publish -c Release -r win-x64 --self-contained -p:PublishTrimmed=true

# Publish to specific folder
dotnet publish -o ./publish
```

---

## 📦 NuGet Package Manager

### Package Installation & Management
```bash
# Add package to project
dotnet add package Newtonsoft.Json

# Add specific version
dotnet add package Newtonsoft.Json --version 13.0.3

# Add package with prerelease versions
dotnet add package Microsoft.EntityFrameworkCore --prerelease

# Remove package
dotnet remove package Newtonsoft.Json

# List installed packages
dotnet list package

# List outdated packages
dotnet list package --outdated

# Update all packages
dotnet add package Microsoft.EntityFrameworkCore

# Update to latest version
dotnet add package Microsoft.EntityFrameworkCore --version *
```

### Package Sources & Configuration
```bash
# List package sources
dotnet nuget list source

# Add package source
dotnet nuget add source https://api.nuget.org/v3/index.json --name nuget.org

# Remove package source
dotnet nuget remove source nuget.org

# Enable package source
dotnet nuget enable source nuget.org

# Disable package source
dotnet nuget disable source nuget.org

# Clear NuGet cache
dotnet nuget locals all --clear
```

### Creating & Publishing Packages
```bash
# Pack project into NuGet package
dotnet pack

# Pack with specific version
dotnet pack -p:PackageVersion=1.0.0

# Pack in Release mode
dotnet pack --configuration Release

# Push package to NuGet.org
dotnet nuget push MyPackage.1.0.0.nupkg --api-key YOUR_API_KEY --source https://api.nuget.org/v3/index.json

# Push to local feed
dotnet nuget push MyPackage.1.0.0.nupkg --source ./local-packages
```

---

## 🎨 Code Formatting with dotnet format

### Basic Formatting Commands
```bash
# Format all files in solution/project
dotnet format

# Format specific project
dotnet format ./MyProject/MyProject.csproj

# Format specific files
dotnet format --include Program.cs

# Dry run (preview changes without applying)
dotnet format --dry-run

# Format and show detailed output
dotnet format --verbosity diagnostic

# Format only whitespace issues
dotnet format whitespace

# Format code style issues
dotnet format style

# Format code analysis issues
dotnet format analyzers
```

### EditorConfig Integration
Create `.editorconfig` file in project root:
```ini
# EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file
root = true

# All files
[*]
indent_style = space
end_of_line = crlf
insert_final_newline = true
trim_trailing_whitespace = true

# C# files
[*.cs]
indent_size = 4

# Code style rules
dotnet_sort_system_directives_first = true
dotnet_separate_import_directive_groups = false

# Naming conventions
dotnet_naming_rule.interfaces_should_be_prefixed_with_i.severity = warning
dotnet_naming_rule.interfaces_should_be_prefixed_with_i.symbols = interface
dotnet_naming_rule.interfaces_should_be_prefixed_with_i.style = prefix_interface_with_i

# Symbol specifications
dotnet_naming_symbols.interface.applicable_kinds = interface
dotnet_naming_symbols.interface.applicable_accessibilities = public, internal, private, protected, protected_internal, private_protected

# Naming styles
dotnet_naming_style.prefix_interface_with_i.required_prefix = I
dotnet_naming_style.prefix_interface_with_i.capitalization = pascal_case
```

---

## 🔍 Linting & Code Analysis

### Built-in Code Analysis
```bash
# Enable code analysis in project file
# Add to .csproj:
<PropertyGroup>
  <EnableNETAnalyzers>true</EnableNETAnalyzers>
  <AnalysisLevel>latest</AnalysisLevel>
  <TreatWarningsAsErrors>true</TreatWarningsAsErrors>
  <WarningsAsErrors />
  <WarningsNotAsErrors>CS1591</WarningsNotAsErrors>
</PropertyGroup>
```

### Popular Code Analysis Packages
```bash
# Add StyleCop analyzers
dotnet add package StyleCop.Analyzers

# Add Microsoft code analysis
dotnet add package Microsoft.CodeAnalysis.Analyzers

# Add security analyzers
dotnet add package Microsoft.CodeAnalysis.BannedApiAnalyzers

# Add performance analyzers
dotnet add package Microsoft.CodeAnalysis.PerformanceSensitiveAnalyzers

# Add async analyzers
dotnet add package AsyncUsageAnalyzers
```

### Custom Analyzer Rules
Create `Directory.Build.props` in solution root:
```xml
<Project>
  <PropertyGroup>
    <EnableNETAnalyzers>true</EnableNETAnalyzers>
    <AnalysisLevel>latest</AnalysisLevel>
    <CodeAnalysisRuleSet>$(MSBuildThisFileDirectory)analyzers.ruleset</CodeAnalysisRuleSet>
  </PropertyGroup>
  
  <ItemGroup>
    <PackageReference Include="StyleCop.Analyzers" Version="1.1.118">
      <PrivateAssets>all</PrivateAssets>
      <IncludeAssets>runtime; build; native; contentfiles; analyzers</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

Create `analyzers.ruleset`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<RuleSet Name="Custom Rules" ToolsVersion="16.0">
  <Rules AnalyzerId="StyleCop.Analyzers" RuleNamespace="StyleCop.Analyzers">
    <Rule Id="SA1200" Action="None" /> <!-- Using directives should be placed correctly -->
    <Rule Id="SA1633" Action="None" /> <!-- File should have header -->
    <Rule Id="SA1101" Action="None" /> <!-- Prefix local calls with this -->
  </Rules>
</RuleSet>
```

### Global AnalyzerConfig
Create `.globalconfig` file:
```ini
# Global analyzer configuration
is_global = true

# Code style rules
dotnet_style_qualification_for_field = false:suggestion
dotnet_style_qualification_for_property = false:suggestion
dotnet_style_qualification_for_method = false:suggestion
dotnet_style_qualification_for_event = false:suggestion

# Language rules
csharp_prefer_braces = true:warning
csharp_prefer_simple_using_statement = true:suggestion
csharp_style_namespace_declarations = file_scoped:warning

# Formatting rules
csharp_new_line_before_open_brace = all
csharp_new_line_before_else = true
csharp_new_line_before_catch = true
csharp_new_line_before_finally = true
```

---

## 🛠️ Development Workflow Integration

### Pre-commit Hooks with Husky.NET
```bash
# Install Husky.NET
dotnet add package Husky

# Initialize Husky
dotnet husky install

# Add pre-commit hook
dotnet husky add .husky/pre-commit -c "dotnet format --verify-no-changes"
```

### GitHub Actions Workflow
Create `.github/workflows/dotnet.yml`:
```yaml
name: .NET

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup .NET
      uses: actions/setup-dotnet@v3
      with:
        dotnet-version: 8.0.x
        
    - name: Restore dependencies
      run: dotnet restore
      
    - name: Check formatting
      run: dotnet format --verify-no-changes
      
    - name: Build
      run: dotnet build --no-restore
      
    - name: Test
      run: dotnet test --no-build --verbosity normal
```

### VS Code Integration
Create `.vscode/settings.json`:
```json
{
  "omnisharp.enableEditorConfigSupport": true,
  "omnisharp.enableRoslynAnalyzers": true,
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true,
    "source.organizeImports": true
  },
  "dotnet.format.enable": true
}
```

---

## 📋 Common Workflows & Best Practices

### New Project Setup Checklist
```bash
# 1. Create solution and projects
dotnet new sln -n MySolution
dotnet new webapi -n MySolution.Api
dotnet new classlib -n MySolution.Core
dotnet new xunit -n MySolution.Tests

# 2. Add projects to solution
dotnet sln add MySolution.Api/MySolution.Api.csproj
dotnet sln add MySolution.Core/MySolution.Core.csproj
dotnet sln add MySolution.Tests/MySolution.Tests.csproj

# 3. Add project references
cd MySolution.Api && dotnet add reference ../MySolution.Core/MySolution.Core.csproj
cd ../MySolution.Tests && dotnet add reference ../MySolution.Core/MySolution.Core.csproj

# 4. Add common packages
cd ../MySolution.Api && dotnet add package Swashbuckle.AspNetCore
cd ../MySolution.Tests && dotnet add package Microsoft.AspNetCore.Mvc.Testing

# 5. Setup code analysis
# Create .editorconfig, Directory.Build.props, and .globalconfig files

# 6. Initial build and test
dotnet build
dotnet test
```

### Continuous Integration Commands
```bash
# Full CI pipeline commands
dotnet restore
dotnet format --verify-no-changes
dotnet build --no-restore --configuration Release
dotnet test --no-build --configuration Release --logger trx --collect:"XPlat Code Coverage"
dotnet publish --no-build --configuration Release --output ./publish
```

### Package Management Best Practices
```bash
# Use central package management (Directory.Packages.props)
<Project>
  <PropertyGroup>
    <ManagePackageVersionsCentrally>true</ManagePackageVersionsCentrally>
  </PropertyGroup>
  
  <ItemGroup>
    <PackageVersion Include="Newtonsoft.Json" Version="13.0.3" />
    <PackageVersion Include="Microsoft.EntityFrameworkCore" Version="7.0.0" />
  </ItemGroup>
</Project>

# In project files, omit version numbers
<PackageReference Include="Newtonsoft.Json" />
```

---

## ✅ Summary

* **Project Management**: Use `dotnet new`, `dotnet sln`, and `dotnet add reference` for project setup
* **Package Management**: Use `dotnet add package`, `dotnet list package`, and `dotnet nuget` commands
* **Code Formatting**: Use `dotnet format` with `.editorconfig` for consistent code style
* **Code Analysis**: Enable analyzers with `EnableNETAnalyzers` and use StyleCop, security analyzers
* **CI/CD Integration**: Combine formatting checks, builds, and tests in automated pipelines
* **Best Practices**: Use central package management, pre-commit hooks, and consistent configuration

The .NET CLI provides comprehensive tooling for modern C# development with built-in support for formatting, linting, and package management that integrates seamlessly with popular editors and CI/CD systems.