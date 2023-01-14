document.addEventListener("DOMContentLoaded", function(event) {
    safari.extension.dispatchMessage("Hello World!");
});

safari.self.addEventListener("message", function(event) {
    console.log(event.name);
    console.log(event.message);
})
