<template>
    <div>
        <div>
            <SelectMap></SelectMap>
            <LoadMap></LoadMap>
        </div>
    </div>
</template>
<script>

import LoadMap from '@/components/user/geo/LoadMap.vue'
import SelectMap from '@/components/user/geo/SelectMap.vue'

export default {
    name: "UserMain",
    components: {
        LoadMap,
        SelectMap,
    },
}
</script>
<style scoped>
</style>