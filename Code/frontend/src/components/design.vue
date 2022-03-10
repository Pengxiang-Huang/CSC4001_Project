<template>
  <div id = "app">
    <div class="select">
      <select>
        <option value="1">Love CS</option>
        <option value="2">Hate CS</option>
        <option value="3">whatever</option>
      </select>
    </div>
    <div class = "link"><p>click here to finish <a href="https://codepen.io/raubaca/pen/bGWmZje" target="_blank">continue</a></p>
    </div>
  </div>
</template>

<style scoped>
#app{
  background: linear-gradient(30deg, #f39c12 30%, #f1c40f);
}
link{
  top: 50%;
  background: red;
}
h1 {
  margin: 0 0 0.25em;
}
a {
  font-weight: bold;
  color: var(--gray);
  text-decoration: none;
  padding: .25em;
  border-radius: .25em;
  background: white;
}
.select{
  top: 50%;
  left: 50%;
}
select {
  /* Reset Select */
  appearance: none;
  outline: 0;
  border: 0;
  box-shadow: none;
  /* Personalize */
  flex: 1;
  padding: 0 1em;
  color: #fff;
  background-color: var(--darkgray);
  background-image: none;
  cursor: pointer;
}
/* Remove IE arrow */
select::-ms-expand {
  display: none;
}
/* Custom Select wrapper */
.select {
  position: relative;
  display: flex;
  width: 20em;
  height: 3em;
  border-radius: .25em;
  overflow: hidden;
}
/* Arrow */
.select::after {
  content: '\25BC';
  position: absolute;
  top: 0;
  right: 0;
  padding: 1em;
  background-color: #34495e;
  transition: .25s all ease;
  pointer-events: none;
}
/* Transition */
.select:hover::after {
  color: #f39c12;
}

</style>
