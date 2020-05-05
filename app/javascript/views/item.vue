<template>
  <div>
    <b-container class="bv-example-row">
      <b-row>
         <b-col>
            <b-breadcrumb :items="breadcrumbs"></b-breadcrumb>
        </b-col>
      </b-row>
    </b-container>

    <b-container class="bv-example-row">
      <b-row>
        <b-col cols="9">
          <div style="height: 500px;width: 100%">
            <gmap-map :center="center" :zoom='5' style="width: 100%; height: 100%" ref="map" >
              <gmap-polygon :paths="item.polygon" :editable="false" />
            </gmap-map>
          </div>
        </b-col>
        <b-col cols="3">

          <b-list-group>
            <b-list-group-item v-for="(v,k) in item">{{k}}: {{v}}</b-list-group-item>
          </b-list-group>

        </b-col>
      </b-row>
    </b-container>
  </div>

</template>

<script>

  export default {
    props: ["id"],
    computed:{
      item(){
        return this.$store.getters["getItem"]
      }
    },
    data(){
      return {
        center: {lat:49, lng:32},
        breadcrumbs: [
          {
            text: 'Main',
            href: '#/'
          },
          {
            text: 'List',
            href: '#/list'
          },
          {
            text: 'Item',
            active: true
          }
        ]


      }
    },
    created(){
      this.$store.dispatch('Show', this.id).then(response => {
        if(response.success){
          setTimeout(() => this.fit(), 1000);
        }
      }, error => {
        console.log(error)
      });
    },
    methods:{
      fit(){
        let bounds = new google.maps.LatLngBounds();
        this.item.polygon.forEach((point) => {
          bounds.extend(new google.maps.LatLng(point.lat, point.lng));
        });
        this.$refs.map.$mapObject.fitBounds(bounds);
      }
    }
  }
</script>



      
      


