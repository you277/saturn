
const numCourses = 99
const numRooms = 800
const periods = 10
const numTeachers = 129

let classInserts = []
let studentInserts = []
let scheduleInserts = []

let teacherSchedules = []
let classPeriods = []
let taken = {}

let classesByPeriod = [
    [], [], [], [], [],
    [], [], [], [], []
]

for (let i = 0; i < numTeachers; i++) {
    let teacherId = i + 1
    let classId = teacherId
    let courseId = i%numCourses + 1
    let roomId = Math.ceil(Math.random()*numRooms)
    let period = Math.ceil(Math.random()*periods)
    while (`${roomId}-${period}` in taken) {
        roomId = Math.ceil(Math.random()*numRooms)
        period = Math.ceil(Math.random()*periods)
    }
    classInserts.push(`INSERT INTO classes (id,room_id,course_id) VALUES (${classId},${roomId},${courseId});`)
    classesByPeriod[period - 1].push(classId)

    scheduleInserts.push(`INSERT INTO schedules (id,pd${period}) VALUES (${teacherId},${classId});`)


    // if (teacherSchedules[teacherId]) {
    //     teacherSchedules[teacherId] = {}
    // }
    // teacherSchedules[teacherId][period] = classId

    // classPeriods.push({
    //     classId: classId,
    //     period: period,
    //     roomId: roomId
    // })
}

// for (let teacherId of Object.keys(teacherSchedules)) {
//     let sched = teacherSchedules[teacherId]
//     let periods = []
//     let classIds = []
//     for (let period of Object.keys(sched)) {
//         periods.push(periods, `p${period}`)
//         classIds.push(sched[period])
//     }
//     scheduleInserts.push(`INSERT INTO schedules (id,${periods.join(",")}) VALUES (${teacherId},${classIds.join(",")});`)
// }

// 5000 students
for (let i = 1; i <= 5000; i++) {
    let scheduleId = numTeachers + i
    let keys = []
    let classIds = []
    for (let i = 0; i < 10; i++) {
        let classes = classesByPeriod[i]
        classIds.push(classes[Math.floor(Math.random()*classes.length)])
        keys.push(`pd${i + 1}`)
    }
    studentInserts.push(`INSERT INTO students (id,first_name,last_name,schedule_id) VALUES (${i},'John${i}','Doe${i}',${scheduleId});`)
    scheduleInserts.push(`INSERT INTO schedules (id,${keys.join(",")}) VALUES (${scheduleId},${classIds.join(",")});`)
}

console.log([
    classInserts.join("\n"),
    scheduleInserts.join("\n"),
    studentInserts.join("\n")
]. join("\n"))
//console.log(classesByPeriod)
// console.log(classPeriods)
