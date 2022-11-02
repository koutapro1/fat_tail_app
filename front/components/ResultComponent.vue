<template>
  <v-app>
    <v-main>
      <v-container fluid class="main-container">
        <top-images-component />
        <div v-for="result in results" class="d-flex">
          <div v-if="result.visual.length > 0" class="visual">
            <span v-for="visual in result.visual">
              {{visual}}
            </span>
          </div>
          <div v-else class="visual">
            <span>
              Normal
            </span>
          </div>
          <div v-if="result.het.length > 0" class="het pl-2 pr-5">
            het
            <span v-for="het in result.het">
              {{het}}
            </span>
          </div>
          <div class="possibility">
            {{result.possibility}}%
          </div>
        </div>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
  export default {
    props: [
      'results'
    ],
  }
</script>