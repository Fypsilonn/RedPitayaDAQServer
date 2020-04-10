using RedPitayaDAQServer, Documenter

makedocs(
    format = Documenter.HTML(prettyurls = false),
    modules = [RedPitayaDAQServer],
    sitename = "RP DAQ Server",
    authors = "Tobias Knopp, Jonas Beuke, Matthias Gräser",
    pages = [
        "Home" => "index.md",
        "Installation" => "installation.md",
        "Architecture" => "architecture.md",
        "FPGA Development" => "fpga.md",
        #"Getting Started" => "overview.md",
    ]
#    html_prettyurls = false, #!("local" in ARGS),
)

deploydocs(repo   = "github.com/tknopp/RedPitayaDAQServer.jl.git",
           target = "build")
