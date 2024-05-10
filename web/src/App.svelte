<script lang="ts">
  import { onMount } from 'svelte';
  import { ReceiveNUI } from "./utils/ReceiveNUI";
  import { SendNUI } from "./utils/SendNUI";
  import { Locale } from './store/stores';
  import { scale } from "svelte/transition";
  import { IconSettings, IconLogout, IconMap } from "@tabler/icons-svelte";
  import Disconnect from './lib/Disconnect.svelte';

  let openUI: boolean = false;
  let showDisconnectDialog: boolean = false;
  
  ReceiveNUI("openUI", async () => {
    openUI = true;
  });
  
  function handleKeydown(event: KeyboardEvent) {
    if (event.key === "Escape") {
      openUI = false;
      SendNUI("closeUI", {});
    }
  }
  
  onMount(() => {
    window.addEventListener('keydown', handleKeydown);
    return () => window.removeEventListener('keydown', handleKeydown)
  });
  
  function openMap() {
    closeUI();
    SendNUI("openMap", {});
  }
  
  function openSettings() {
    closeUI();
    SendNUI("openSettings", {});
  }
  
  function disconnect() {
    showDisconnectDialog = true;
  }
  
  function closeDisconnectDialog() {
    showDisconnectDialog = false;
  }
  
  function closeUI() {
    openUI = false;
    SendNUI("closeUI", {});
  }
</script>

{#if openUI}
<main in:scale out:scale>
  <div class="flex justify-center items-center h-screen">
    <div class="rounded-lg w-[130vh] h-[70vh]">
      <div class="flex flex-col h-full">
        <div class="flex flex-1">
          <div class="w-[90vh] mr-4">
            <button on:click={openMap} class="bg-neutral-800 rounded-lg flex flex-col items-center justify-center h-full w-full relative overflow-hidden transition-all duration-300 hover:bg-neutral-900">
              <img src="assets/map.png" alt="Map" class="h-[70vh] w-[90vh] opacity-20 rounded-lg transition-transform duration-300 transform hover:scale-105"/>
            </button>
          </div>  
          <div class="flex-1 flex flex-col justify-center">
            <button on:click={openSettings} class="bg-neutral-800 opacity-80 rounded-lg flex flex-col items-center justify-center h-full relative transition-all duration-300 hover:bg-neutral-900">
              <IconSettings size={75} class="transform hover:scale-110 transition-all duration-300" />
              <span class="text-xl font-bold uppercase mt-2 opacity-80">{$Locale.settings}</span>
              <div class="absolute bottom-0 w-full h-full rounded-full bg-neutral-500 opacity-20 filter blur-[50px] transition-all duration-300 pointer-events-none"></div>
            </button>
                        
            <button on:click={disconnect} class="bg-neutral-800 opacity-80 rounded-lg flex flex-col items-center justify-center h-full mt-4 relative transition-all duration-300 hover:bg-neutral-900">
              <IconLogout size={75} class="transform hover:scale-110 transition-all duration-300" />
              <span class="text-xl font-bold uppercase mt-2 opacity-80">{$Locale.disconnect}</span>
              <div class="absolute bottom-0 w-full h-full rounded-full bg-neutral-500 opacity-20 filter blur-[50px] transition-all duration-300 pointer-events-none"></div>
            </button>
          </div>
        </div>
      </div>          
    </div>
  </div>
</main>
{/if}

<Disconnect bind:showDisconnectDialog on:close={closeDisconnectDialog}/>
