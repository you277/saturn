/*
    creates classes, students, schedules, assignments, and grades
*/

const fs = require("fs")

const numCourses = 99
const numRooms = 800
const periods = 10
const numTeachers = 129

let classInserts = []
let studentInserts = []
let scheduleInserts = []
let assignmentInserts = []
let gradeInserts = []

let teacherSchedules = []
let classPeriods = []
let taken = {}

let courseClasses = {}

let classesByPeriod = [
    [], [], [], [], [],
    [], [], [], [], []
]

let assignments = {
    // [classId]: [assignmentId]
}

let curAssignmentId = 0

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
    taken[`${roomId}-${period}`] = true
    classInserts.push(`INSERT INTO classes (id,room_id,course_id) VALUES (${classId},${roomId},${courseId});`)
    classesByPeriod[period - 1].push(classId)

    if (!courseClasses[courseId]) {
        courseClasses[courseId] = []
    }
    courseClasses[courseId].push(classId)

    scheduleInserts.push(`INSERT INTO schedules (id,pd${period}) VALUES (${teacherId},${classId});`)
}

function addAssignment(classId, assignmentType) {
    curAssignmentId++
    let name = `assignment_${curAssignmentId}`
    assignmentInserts.push(`INSERT INTO assignments (id,class_id,name,type) VALUES (${curAssignmentId},${classId},'${name}',${assignmentType});`)
    let list = assignments[classId]
    if (!list) {
        list = []
        assignments[classId] = list
    }
    list.push(curAssignmentId)
}

for (let courseId of Object.keys(courseClasses)) {
    let classIds = courseClasses[courseId]
    let classId = classIds[Math.floor(Math.random()*classIds.length)]
    for (let i = 0; i < 12; i++) {
        addAssignment(classId, 1)
    }
    for (let i = 0; i < 3; i++) {
        addAssignment(classId, 2)
    }
}

// 5000 students
for (let studentId = 1; studentId <= 5000; studentId++) {
    let scheduleId = numTeachers + studentId
    let keys = []
    let classIds = []
    for (let i = 0; i < 10; i++) {
        let classes = classesByPeriod[i]
        let classId = classes[Math.floor(Math.random()*classes.length)]
        classIds.push(classId)
        keys.push(`pd${i + 1}`)

        if (assignments[classId]) {
            for (let assignmentId of assignments[classId]) {
                let grade = 75 + Math.round(Math.random()*25)
                gradeInserts.push(`INSERT INTO grades (assignment_id,student_id,grade) VALUES (${assignmentId},${studentId},${grade});`)
            }
        }
    }
    studentInserts.push(`INSERT INTO students (id,first_name,last_name,schedule_id) VALUES (${studentId},'John${studentId}','Doe${studentId}',${scheduleId});`)
    scheduleInserts.push(`INSERT INTO schedules (id,${keys.join(",")}) VALUES (${scheduleId},${classIds.join(",")});`)
}

fs.writeFileSync("data/classes.sql", classInserts.join("\n"))
fs.writeFileSync("data/assignments.sql", assignmentInserts.join("\n"))
fs.writeFileSync("data/schedules.sql", scheduleInserts.join("\n"))
fs.writeFileSync("data/students.sql", studentInserts.join("\n"))
fs.writeFileSync("data/grades.sql", gradeInserts.join("\n"))
