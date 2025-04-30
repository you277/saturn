/*
    creates classes, students, schedules, assignments, and grades
*/

const fs = require("fs")

const numCourses = 99
const numRooms = 720
const periods = 10
const numTeachers = 324
const gradeSplit = 100000

let classInserts = []
let studentInserts = []
let teacherScheduleInserts = []
let studentScheduleInserts = []
let assignmentInserts = []
let gradeInserts = []

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
    classInserts.push(`(${classId},${roomId},${courseId})`)
    classesByPeriod[period - 1].push(classId)

    if (!courseClasses[courseId]) {
        courseClasses[courseId] = []
    }
    courseClasses[courseId].push(classId)

    teacherScheduleInserts.push(`INSERT INTO schedules (id,pd${period}) VALUES (${teacherId},${classId});`)
}

function addAssignment(classId, assignmentType) {
    curAssignmentId++
    let name = `assignment_${curAssignmentId}`
    assignmentInserts.push(`(${curAssignmentId},${classId},'${name}',${assignmentType})`)
    let list = assignments[classId]
    if (!list) {
        list = []
        assignments[classId] = list
    }
    list.push(curAssignmentId)
}

for (let courseId of Object.keys(courseClasses)) {
    let classIds = courseClasses[courseId]
    // let classId = classIds[Math.floor(Math.random()*classIds.length)]
    for (let classId of classIds) {
        for (let i = 0; i < 12; i++) {
            addAssignment(classId, 1)
        }
        for (let i = 0; i < 3; i++) {
            addAssignment(classId, 2)
        }
    }
}

// 5000 students
for (let studentId = 1; studentId <= 5000; studentId++) {
    let scheduleId = numTeachers + studentId
    let classIds = []
    for (let i = 0; i < 10; i++) {
        let classes = classesByPeriod[i]
        let classId = classes[Math.floor(Math.random()*classes.length)]
        classIds.push(classId)

        if (assignments[classId]) {
            for (let assignmentId of assignments[classId]) {
                let grade = 75 + Math.round(Math.random()*25)
                gradeInserts.push(`(${assignmentId},${studentId},${grade})`)
            }
        }
    }
    studentInserts.push(`(${studentId},'John${studentId}','Doe${studentId}',${scheduleId})`)
    studentScheduleInserts.push(`(${scheduleId},${classIds.join(",")})`)
}

function s(header, values) {
    return `${header}\n${values.join(",\n")};`
}

fs.writeFileSync("data/classes.sql", s("INSERT INTO classes (id,room_id,course_id) VALUES", classInserts))
fs.writeFileSync("data/assignments.sql", s("INSERT INTO assignments (id,class_id,name,type) VALUES", assignmentInserts))

let teacherScheduleResult = teacherScheduleInserts.join("\n")
let studentHeader = `INSERT INTO schedules (id,pd1,pd2,pd3,pd4,pd5,pd6,pd7,pd8,pd9,pd10) VALUES`
let studentSchedulesResult = s(studentHeader, studentScheduleInserts)
fs.writeFileSync("data/schedules.sql", teacherScheduleResult + "\n" + studentSchedulesResult)
fs.writeFileSync("data/students.sql", s("INSERT INTO students (id,first_name,last_name,schedule_id) VALUES", studentInserts))


let i = 1
while (true) {
    let joins = gradeInserts.splice(0, gradeSplit)
    if (joins.length == 0) break
    let res = s("INSERT INTO grades (assignment_id,student_id,grade) VALUES", joins)
    fs.writeFileSync(`data/grades/${i}.sql`, res)
    i++
}
