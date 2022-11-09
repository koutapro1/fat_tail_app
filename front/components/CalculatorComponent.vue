<template>
  <div>
    <div class="search-form">
      <v-row justify="space-around" align-content="center" class="select-area">
        <v-col cols="6" sm="5" class="male-search-form">
          <h2>♂ Male</h2>
          <div class="male-select-container">
            <v-autocomplete
              class="male-visual-select"
              v-model="selected_morphs.male_visual"
              :items="morphs"
              label="male visual"
              item-value="symbol"
              item-text="name"
              color="white"
              chips
              deletable-chips
              multiple
            ></v-autocomplete>
            <v-autocomplete
              v-model="selected_morphs.male_het"
              :items="morphs"
              label="male het"
              item-value="symbol"
              item-text="name"
              color="white"
              chips
              deletable-chips
              multiple
            ></v-autocomplete>
            <img src="~assets/images/stems/oreo.png" class="gecko-image-left">
          </div>
        </v-col>
        <v-col cols="6" sm="5" class="female-search-form">
          <h2>♀ Female</h2>
          <div class="female-select-container">
            <v-autocomplete
              v-model="selected_morphs.female_visual"
              :items="morphs"
              label="female visual"
              item-value="symbol"
              item-text="name"
              color="white"
              chips
              deletable-chips
              multiple
            ></v-autocomplete>
            <v-autocomplete
              v-model="selected_morphs.female_het"
              :items="morphs"
              label="female het"
              item-value="symbol"
              item-text="name"
              color="white"
              chips
              deletable-chips
              multiple
            ></v-autocomplete>
            <img src="~assets/images/stems/oreo.png" class="gecko-image-right">
          </div>
        </v-col>
      </v-row>
    </div>
    <div class="submit-area">
      <img src="~assets/images/stems/egg.png" class="egg-image">
        <button @click="searchResult" class="ok-button">OK</button>
    </div>
  </div>
</template>

<script>
  export default {
    props: [
      'morphs',
      'selected_morphs',
    ],
    computed:{
      selected_morphs_computed:{
        get(){
          return this.selected_morphs;
        },
        set(newVal){
          this.$emit("set-selected-morphs", newVal);
        }
      }
    },
    methods: {
      searchResult() {
        this.$emit('search-result')
      }
    }
  }
</script>