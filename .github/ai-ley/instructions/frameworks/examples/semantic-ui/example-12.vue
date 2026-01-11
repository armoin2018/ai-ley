<template>
  <div class="ui form">
    <div class="field">
      <input v-model="name" placeholder="Name" />
    </div>
    <button class="ui primary button" @click="submit">Submit</button>
  </div>
</template>