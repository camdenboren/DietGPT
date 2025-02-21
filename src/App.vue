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
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbList,
} from "./components/ui/breadcrumb";
import { Separator } from "./components/ui/separator";
import {
  SidebarInset,
  SidebarProvider,
  SidebarTrigger,
} from "./components/ui/sidebar";

const routes: { [index: string]: Component } = {
  "/usage": Usage,
  "/": MealPlanning,
  "/calorie-counting": CalorieCounting,
  "/project": Project,
};

const routeNames: { [index: string]: string } = {
  "/usage": "Usage",
  "/": "Meal Planning",
  "/calorie-counting": "Calorie Counting",
  "/project": "Project",
};

const currentPath = ref(window.location.hash);

window.addEventListener("hashchange", () => {
  currentPath.value = window.location.hash;
});

const currentView = computed(() => {
  return routes[currentPath.value.slice(1) || "/"] || NotFound;
});

const currentName = computed(() => {
  return routeNames[currentPath.value.slice(1) || "/"] || "404";
});
</script>

<template>
  <div class="wrapper">
    <SidebarProvider>
      <Sidebar />
      <SidebarInset>
        <header class="flex h-16 shrink-0 items-center gap-2 border-b px-4">
          <SidebarTrigger class="-ml-1" />
          <Separator orientation="vertical" class="mr-2 h-4" />
          <Breadcrumb>
            <BreadcrumbList>
              <BreadcrumbItem class="hidden md:block">
                <span>{{ currentName }}</span>
              </BreadcrumbItem>
            </BreadcrumbList>
          </Breadcrumb>
        </header>
        <component :is="currentView" />
      </SidebarInset>
    </SidebarProvider>
  </div>
</template>
