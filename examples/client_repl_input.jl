using HTTP
using WebSockets
function client_one_message(ws)
    print_with_color(:green, STDOUT, "\nws|client input >  ")
    msg = readline(STDIN)
    if writeguarded(ws, msg)
        msg, stillopen = readguarded(ws)
        println("Received:", String(msg))
        if stillopen 
            println("The connection is active, but we leave. WebSockets.jl will close properly.")
        else
            println("Disconnect during reading.")
        end
    else
        println("Disconnect during writing.")
    end
end
function main()
    while true
        println("\nWebSocket client side. WebSocket URI format:")
        println("ws:// host [ \":\" port ] path [ \"?\" query ]")
        println("Example:\nws://127.0.0.1:8080")
        println("Where do you want to connect? Empty line to exit")
        print_with_color(:green, STDOUT, "\nclient_repl_input >  ")
        wsuri = readline(STDIN)
        wsuri == "" && break
        res = WebSockets.open(client_one_message, wsuri)
        !isa(res, HTTP.Response) && println(res)
    end
    println("Have a nice day")
end

main()
