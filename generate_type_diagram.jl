# Generate Type Hierarchy Diagram for MPM Project
# Run this with: julia generate_type_diagram.jl
push!(LOAD_PATH,"./")

using InteractiveUtils

# List of modules to analyze
# Note: Order matters - include dependencies first
include("Util.jl")
include("BodyForce.jl")
include("Material.jl")
include("Basis.jl")
include("Grid.jl")
include("Output.jl")

using .Util, .BodyForce, .Material, .Basis, .Grid, .Output

# Generate PlantUML format
function generate_plantuml_diagram()
    # Open file for writing
    open("type_diagram.puml", "w") do io
        println(io, "@startuml MPM_Types")
        println(io, "skinparam classAttributeIconSize 0")
        println(io, "")
    
        # BodyForce types
        println(io, "abstract class BodyForceType")
        for T in subtypes(Main.BodyForce.BodyForceType)
            println(io, "BodyForceType <|-- $(nameof(T))")
            fields = fieldnames(T)
            if !isempty(fields)
                println(io, "class $(nameof(T)) {")
                for f in fields
                    println(io, "  +$(f) : $(fieldtype(T, f))")
                end
                println(io, "}")
            end
        end
        println(io, "")
        
        # Material types
        println(io, "abstract class MaterialType")
        for T in subtypes(Main.Material.MaterialType)
            println(io, "MaterialType <|-- $(nameof(T))")
            fields = fieldnames(T)
            if !isempty(fields)
                println(io, "class $(nameof(T)) {")
                for f in fields[1:min(5, length(fields))]  # Limit to first 5 fields
                    println(io, "  +$(f) : $(fieldtype(T, f))")
                end
                if length(fields) > 5
                    println(io, "  ...")
                end
                println(io, "}")
            end
        end
        println(io, "")
        
        # Basis types
        println(io, "abstract class BasisType")
        for T in subtypes(Main.Basis.BasisType)
            println(io, "BasisType <|-- $(nameof(T))")
        end
        println(io, "")
        
        # Output types
        println(io, "abstract class OutputType")
        for T in subtypes(Main.Output.OutputType)
            println(io, "OutputType <|-- $(nameof(T))")
            fields = fieldnames(T)
            if !isempty(fields)
                println(io, "class $(nameof(T)) {")
                for f in fields
                    println(io, "  +$(f) : $(fieldtype(T, f))")
                end
                println(io, "}")
            end
        end
        
        println(io, "@enduml")
    end
    
    println("Type diagram generated successfully: type_diagram.puml")
end

# Run it
generate_plantuml_diagram()
