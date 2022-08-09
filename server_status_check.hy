(import requests)
(import discord)
(import discord.ext [tasks])


(defn/a is-online [host-url]
    (try 
        (setv r (requests.get host-url :timeout #(2 5)))
        (if (= r.status_code 200)
            (+ "<" host-url "> is alive! 🟢") ;if code equals 200
            (+ "<" host-url "> is dead! 🔴")) ;else    
        (except [requests.exceptions.ConnectionError]
            (+ "<" host-url "> took too long to respond. 🔴"))))

(defn/a [(tasks.loop :hours 1)] do-check [bot channel-id host-url]
    (setv channel (bot.get_channel channel-id))
    (await (channel.send (await (is-online host-url)))))
