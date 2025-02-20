<!-- SPDX-FileCopyrightText: 2025 Camden Boren -->
<!-- SPDX-License-Identifier: GPL-3.0-or-later -->

<script setup lang="ts">
import { computed, ref, type Component } from "vue";
import Sidebar from "./components/Sidebar.vue";
import MealPlanning from "./views/MealPlanning.vue";
import CalorieCounting from "./views/CalorieCounting.vue";
import Usage from "./views/Usage.vue";
import Project from "./views/Project.vue";
import NotFound from "./views/NotFound.vue";

const routes: { [index: string]: any } = {
  "/": Usage,
  "/meal-planning": MealPlanning,
  "/calorie-counting": CalorieCounting,
  "/project": Project,
};

const currentPath = ref(window.location.hash);

window.addEventListener("hashchange", () => {
  currentPath.value = window.location.hash;
});

const currentView = computed(() => {
  return routes[currentPath.value.slice(1) || "/"] || NotFound;
});
</script>

<template>
  <component :is="currentView" />
  <div class="wrapper">
    <Sidebar />
  </div>
</template>
