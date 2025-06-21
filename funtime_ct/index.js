register("chat", (message, event) => {
    console.log("Important: "+message)
    // Reboot message?
    if (message.includes("Scheduled Reboot") && message.includes("warp now")) {
	// farming item?
	item = Player.getHeldItem()
	if (item) {
	    itemstr = item.toString()
	    if (itemstr.includes("hoe") || itemstr.includes("hatchet")) {
		console.log("quit")
		Client.Companion.disconnect()
	    }
	}
    }
}).setCriteria("Important${message}").setContains();


// // Just debug stuff
// register("command", (user) => {
//     //Client.Companion.disconnect()
//     console.log("before dlay")

//     // for (let step = 0; step < 4999999; step++) {
//     // 	// Runs 5 times, with values of step 0 through 4.
//     // 	step++
//     // }

//     console.log(Player.getHeldItem().getTextComponent())
//     console.log(Player.getHeldItem())

//     // if (spaceKeyBind.isKeyDown()) {
//     // 	console.log("keydown")
//     // 	ChatLib.command("is");
//     // }
//     console.log("after dlay")
// }).setName("hicmd");
