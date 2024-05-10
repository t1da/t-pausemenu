import { writable } from "svelte/store";

interface LOCALE_DATA {
  map: string,
  settings: string,
  disconnect: string,
  close: string,
  yes: string,
  no: string,
}

export const Locale = writable<LOCALE_DATA>({
  map: "",
  settings: "",
  disconnect: "",
  close: "",
  yes: "",
  no: "",
});

export async function loadTranslations() {
  try {
    const response = await fetch("language.json");
    const translations: Partial<LOCALE_DATA> = await response.json();
    Locale.update(data => ({ ...data, ...translations }));
  } catch (error) {
    console.error("Error loading translations:", error);
  }
}

loadTranslations();