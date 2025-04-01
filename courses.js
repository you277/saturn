/*
    creates courses
*/

let input = `1|Anatomy
3|Biology
3|Environmental
3|Psychology
1|Bioorganic Chemistry
1|Genetics
1|Introduction to Neuroscience
2|Living Environment
2|Living Environment Lab
1|Environmental Sustainability
2|Chemistry
2|Chemistry Lab
3|Chemistry
1|Chemical Engineering
1|Organic Chemistry
1|MICA
1|Quantitative Analysis
1|Forensics
2|Physics
2|Physics Lab
3|Physics 1
3|Physics 2
3|Physics C (Mechanics)
3|Physics C (E/M)
1|Astronomy
1|Modern Physics
2|Common Core Algebra
2|Common Core Geometry
2|Common Core Algebra II
1|Pre-Calculus
1|Calculus (non-AP)
3|Calculus (AB)
3|Calculus (BC)
3|Statistics
1|Multivariable Calculus
1|Math Research
1|Linear Algebra
3|Computer Science Principles
3|Computer Science A
1|Big Data: Warehousing & Analytics
1|Cyber Security
1|PLTW Digital Electronics
1|Digital Systems Design
1|Fundamentals of IT Infrastructure
1|Green Building Construction
1|PLTW EDD
1|Physical Education
1|Health Education
1|9th Grade English
1|10th Grade English
3|Capstone Seminar
2|11th Grade English
3|English Language & Composition
3|Capstone Research
3|English Literature & Composition
1|Creative Writing
1|Drama
1|Film & Literature
1|Journalism
1|Life, Love & Death
1|Mystery, Horror & the Supernatural
1|Science Fiction & Fantasy
1|Yearbook
1|The Survey
1|9th Grade Global
2|Global History
3|World History
3|European History
2|American History
3|American History
1|Participation in Government
3|US Government
1|Economics
3|Macroeconomics
3|Microeconomics
3|Comparative Government
3|Psychology
3|Human Geography
1|Sociology
1|Cultural Anthropology
1|Physical Anthropology
2|Chinese
3|Chinese Language and Culture
2|French
3|French Language and Culture
2|German
3|German Language and Culture
2|Italian
3|Italian Language and Culture
2|Spanish
1|Spanish IV
3|Spanish Language and Culture
3|Spanish Literature and Culture
1|Adobe Digital Video
1|Adobe Visual Design
1|Architectural Drawing w/CAD
1|Digital Animation
1|PLTW CEA
1|PLTW DDP (9th Grade)`

let lines = input.split("\n")
let inserts = []

for (let i of Object.keys(lines)) {
	let line = lines[i]
	let info = line.split("|")
	let courseType = info[0]
	let courseName = info[1]
	inserts.push(`INSERT INTO courses (id,type,name) VALUES (${Number(i) + 1},${courseType},'${courseName}');`)
}

console.log(inserts.join("\n"))
