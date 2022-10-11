<template>
  <v-app>
    <v-main>
      <v-container fluid class="main-container">
        <div class="top-images">
          <div class="left-leaf">
            <img src="~assets/images/stems/leaf1.png">
          </div>
          <div class="right-leaf">
            <img src="~assets/images/stems/leaf2.png">
          </div>
          <div class="title">
            <img src="~assets/images/stems/title.png">
          </div>
          <div class="left-shadow">
            <img src="~assets/images/stems/left-shadow.png">
          </div>
          <div class="right-shadow">
            <img src="~assets/images/stems/right-shadow.png">
          </div>
        </div>
        <div class="explanation">
          <p>
            All you need to do now is choose the genetics of your pairing below.<br>
            While we have worked incredibly hard to make this genetic calculator as accurate as possible<br>
            (with some new features that other calculators do not have),<br>
            it should be used as a guide and should not be used as a 100% guarantee of your babies<br>
            (as you may have HETs that you are not aware of and haven't added them to the calculation).
          </p>
        </div>
        <div class="search-form-container">
          <div class="search-form">
            <v-row justify="space-around" align-content="center" class="select-row">
              <v-col cols="6" sm="5" class="male-search-form">
                <h2>♂ Male</h2>
                <div class="male-select-container">
                  <v-autocomplete
                    class="male-visual-select"
                    v-model="male_visual"
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
                    v-model="male_het"
                    :items="morphs"
                    label="male het"
                    item-value="symbol"
                    item-text="name"
                    color="white"
                    chips
                    deletable-chips
                    multiple
                  ></v-autocomplete>
                </div>
              </v-col>
              <v-col cols="6" sm="5" class="female-search-form">
                <h2>♀ Female</h2>
                <div class="female-select-container">
                  <v-autocomplete
                    v-model="female_visual"
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
                    v-model="female_het"
                    :items="morphs"
                    label="female het"
                    item-value="symbol"
                    item-text="name"
                    color="white"
                    chips
                    deletable-chips
                    multiple
                  ></v-autocomplete>
                </div>
              </v-col>
            </v-row>
            <v-row>
              <v-col class="egg-image" justify="center">
                <img src="~assets/images/stems/egg.png">
                <div class="button-area">
                  <button @click="moveToResultPage" class="ok-button">OK</button>
                </div>
              </v-col>
            </v-row>
          </div>
        </div>
      </v-container>
    </v-main>
  </v-app>
</template>

<style>
  .main-container
  {
    position: relative;
    padding: 0;
    height: 100%;
  }
  .top-images
  {
    min-height: 11rem;
  }
  .left-leaf
  {
    position: absolute;
    top: -300px;
    left: -300px;
    z-index: 5;
  }
  .right-leaf
  {
    position: absolute;
    top: -300px;
    right: -300px;
    z-index: 5;
  }
  .title
  {
    position: relative;
    top: -300px;
    z-index: 10;
  }
  .title img
  {
    display: block;
    margin: auto;
  }
  .left-shadow
  {
    position: absolute;
    bottom: 0;
    left: 0;
  }
  .right-shadow
  {
    position: absolute;
    bottom: 0;
    right: 0;
  }
  .explanation
  {
    text-align: center;
    font-size: 0.8rem;
    font-weight: bold;
    line-height: 1;
  }
  .search-form-container
  {
    display: flex;
    justify-content: center;
  }
  .search-form
  {
    position: relative;
    min-width: 70vw;
    height: max-content;
  }
  .search-form h2
  {
    width: fit-content;
    margin: auto;
    color: rgb(254,255,255);
    border-bottom: solid 5px rgb(231,219,207);
    text-shadow: 4px 4px 4px rgb(113,87,64);
    font-size: 2rem;
    line-height: 1.2;
  }
  .male-search-form, .female-search-form
  {
    background-color: rgb(179,135,88);
    border: solid 5px rgb(255,255,250);
    border-radius: 5rem;
    z-index: 10;
  }
  .male-select-container, .female-select-container
  {
    padding: 2rem;
  }
  .egg-image
  {
    display: flex;
    justify-content: center;
    position: absolute;
    top: 13rem;
    z-index: 11;
  }
  .egg-image img
  {
    /* z-index: 100; */
  }
  .button-area
  {
    position: absolute;
    bottom: 1rem;
    left: 50%;
    transform: translateX(-50%);
    z-index: 110;
  }
  .ok-button
  {
    background-color: rgb(199,120,90);
    color: rgb(248,255,255);
    border: solid 8px rgb(248,255,255);
    border-radius: 10px;
    font-size: 3rem;
    font-weight: bold;
    text-shadow: 4px 4px 4px rgb(113,87,64);
    width: 10rem;
    height: 5rem;
    box-shadow: 2px 4px 8px rgba(0, 0, 0, 0.7);
    transition: .3s;
  }
  .ok-button:hover
  {
    transform: scale(1.1);
  }
  .ok-button:active
  {
    transform: translate(0,2px);
    box-shadow: 2px 1px 8px rgba(0, 0, 0, 0.7);
  }

  .theme--light.v-label
  {
    color: white !important;
  }

</style>

<script>
  import { mapGetters, mapActions } from 'vuex'
  import anime from 'animejs'

  export default {
    layout: 'plain',
    data() {
      return {
        male_visual: [],
        male_het: [],
        female_visual: [],
        female_het: [],
      }
    },
    computed: {
      ...mapGetters(["morphs"])
    },
    created() {
      this.fetchMorphs();
    },
    mounted() {
      this.setAnimation();
    },
    methods: {
      ...mapActions(["fetchMorphs"]),
      moveToResultPage() {
        this.$router.push({
          path: "/result",
          query: {
            male_visual: this.male_visual,
            male_het: this.male_het,
            female_visual: this.female_visual,
            female_het: this.female_het
          }
        })
      },
      setAnimation() {
        const animation = anime.timeline({});
        const xMax = 16;

        animation
        .add({
          targets: '.left-leaf',
          translateX: 300,
          translateY: 300,
          duration: 500,
          easing: 'easeInOutBack'
        })
        .add({
          targets: '.right-leaf',
          translateX: -300,
          translateY: 300,
          duration: 500,
          easing: 'easeInOutBack'
        }, '-=350')
        .add({
          targets: ['.left-shadow', '.right-shadow'],
          easing: 'easeInOutSine',
          duration: 600,
          opacity: [0, 1]
        }, 100)
        .add({
          targets: '.search-form',
          easing: 'easeInOutSine',
          duration: 600,
          opacity: [0, 1]
        }, 100)
        .add({
          targets: '.title',
          translateY: 300,
          duration: 1000,
          easing: 'easeOutBounce'
        })
        .add({
          targets: '.egg-image',
          easing: 'easeInOutSine',
          duration: 550,
          scale: [1.4, 1, 1],
          translateX: [
            {
              value: xMax * -1,
            },
            {
              value: xMax,
            },
            {
              value: xMax/-2,
            },
            {
              value: xMax/2,
            },
            {
              value: 0
            }
          ],
        })
      }
    }
  }
</script>