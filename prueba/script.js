// Conectamos a PocketBase local
const pb = new PocketBase('http://192.168.100.3:8090');

// Referencias
const form = document.getElementById('form-tarea');
const lista = document.getElementById('lista-tareas');

// Mostrar tareas
async function cargarTareas() {
    lista.innerHTML = '';
    const tareas = await pb.collection('tareas').getFullList();
    tareas.forEach(t => {
        const li = document.createElement('li');
        li.innerHTML = `
            <strong>${t.titulo}</strong> - ${t.descripcion}
            <button onclick="eliminarTarea('${t.id}')">🗑️</button>
        `;
        lista.appendChild(li);
    });
}

// Agregar tarea
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const titulo = document.getElementById('titulo').value;
    const descripcion = document.getElementById('descripcion').value;

    await pb.collection('tareas').create({
        titulo,
        descripcion,
        completado: false
    });

    form.reset();
    cargarTareas();
});

// Eliminar tarea
async function eliminarTarea(id) {
    await pb.collection('tareas').delete(id);
    cargarTareas();
}

// Cargar al inicio
cargarTareas();
