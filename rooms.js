/*
    creates rooms
*/

let inserts = []
let floorSections = ["N","W","E","S"]

let roomId = 1

for (let f = 0; f <= 8; f++) {
	let floor = f == 0 ? "B" : f
	for (let i = 1; i <= 20; i++ ) {
		for (let section of floorSections) {
			inserts.push(`INSERT INTO rooms (id,name) VALUES (${roomId},'${floor}${section}${i}');`)
            roomId += 1
		}
	}
}

console.log(inserts.join("\n"))
