let data = [
    {
        name: 'Rama',
        age: 30
    },
    {
        name: 'Krishna',
        age: 30
    },
    {
        name: 'Radha',
        age: 30
    },
    {
        name: 'Gopi',
        age: 30
    },
    {
        name: 'Lakshmana',
        age: 30
    },
    {
        name: 'Hanumanta',
        age: 30
    },
]

const info = document.querySelector("#info");

let details = data.map(function(item) {
    return '<div>' + item.name + ' is ' + item.age + ' years old'  + '</div>';
})

info.innerHTML = details.join('\n')