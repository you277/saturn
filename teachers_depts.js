/*
    creates teachers and their assignments
*/

function parseName(full) {
	let segments = []
	for (let s of full.split(" ")) {
		if (s == "") continue
		if (s.match(/\.$/)) continue
		if (s.match(/\(.+\)/)) break
		segments.push(s)
	}
	let first = segments.splice(0, 1)[0]
	return [first.replace("'", "''"), segments.join(" ").replace("'", "''")]
}

function trim(str) {
	return str.match(/^\s*(.+)\s*$/)[1]
}

let killTheseOnes = ["Administration - Supervisors"]

let seen = {}
let teacherNames = []
let people = []
let final = []

for (let category of document.getElementsByClassName("staff-category")) {
	let header = category.getElementsByClassName("staff-header")[0]
	let categoryName = header.getElementsByTagName("h1")[0].textContent
	if (!categoryName) continue
	categoryName = trim(categoryName)
	if (killTheseOnes.includes(categoryName)) {
		continue
	}
	for (let staff of category.getElementsByClassName("staff-categoryStaffMember")) {
		let wrapper = staff.getElementsByClassName("staffPhotoWrapperRound")[1]
		let nameTag = wrapper.getElementsByTagName("dt")[0]
		let title = wrapper.getElementsByTagName("dd")[0]
		if (!title) continue
		console.log(categoryName, categoryName == "Teacher")
		if (categoryName == "Teachers") {
			teacherNames.push(trim(nameTag.textContent))
		} else {
			people.push({
				nameStr: trim(nameTag.textContent),
				category: trim(categoryName)
			})
		}
	}
}

let departments = []
let teacherInserts = []
let departmentInserts = []
let inserted = []

let teacherId = 1

for (let i of Object.keys(people)) {
	let teacher = people[i]
	if (teacherNames.includes(teacher.nameStr)) {
		if (!teacher.category) continue
		if (inserted.includes(teacher.nameStr)) continue
		if (!departments.includes(teacher.category)) {
			departments.push(teacher.category)
		}
		inserted.push(teacher.nameStr)
		let departmentId = departments.indexOf(teacher.category)
		let [firstName, lastName] = parseName(teacher.nameStr)
		teacherInserts.push(`INSERT INTO teachers (id,department_id,first_name,last_name,schedule_id) VALUES (${teacherId},${departmentId + 1},'${firstName}','${lastName}',${teacherId});`)
		teacherId += 1
	}
}

for (let i of Object.keys(departments)) {
	departmentInserts.push(`INSERT INTO departments (id,name) VALUES (${Number(i)+1},'${departments[i]}');`)
}

// let scheduleInserts = []
// for (let i in inserted) {
// 	scheduleInserts.push(`INSERT INTO schedules (id) VALUES (${Number(i)+1});`)
// }

console.log([
    // scheduleInserts.join("\n"),
    departmentInserts.join("\n"),
    teacherInserts.join("\n")
].join("\n"))
