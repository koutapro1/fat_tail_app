<template>
  <v-container>
    <v-layout justify-space-around wrap>
      <v-flex xs5 sm5 md4>
        <v-autocomplete
          v-model="selected_male_visual"
          :items="morphs"
          label="male visual"
          item-value="symbol"
          item-text="name"
          chips
          deletable-chips
          multiple
        ></v-autocomplete>
        <v-autocomplete
          v-model="selected_male_het"
          :items="morphs"
          label="male het"
          item-value="symbol"
          item-text="name"
          chips
          deletable-chips
          multiple
        ></v-autocomplete>
      </v-flex>
      <v-flex xs5 sm5 md4>
        <v-autocomplete
          v-model="selected_female_visual"
          :items="morphs"
          label="female visual"
          item-value="symbol"
          item-text="name"
          chips
          deletable-chips
          multiple
        ></v-autocomplete>
        <v-autocomplete
          v-model="selected_female_het"
          :items="morphs"
          label="female het"
          item-value="symbol"
          item-text="name"
          chips
          deletable-chips
          multiple
        ></v-autocomplete>
      </v-flex>
    </v-layout>
  </v-container>
</template>
<script>
import axios from "~/plugins/axios"

export default {
  data() {
    return {
      morphs: [],
      selected_male_visual: [],
      selected_male_het: [],
      selected_female_visual: [],
      selected_female_het: [],
      results: []
    }
  },
  created() {
    this.fetchMorphs();
  },
  methods: {
    fetchMorphs() {
      axios.get("/morphs").then(res => {
        if (res.data) {
          this.morphs = res.data
        }
      })
    },
  }
}
</script>