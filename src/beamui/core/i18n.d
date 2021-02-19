/**
Contains UI localization support.

Supports fallback to another translation file (e.g. default language).

Set interface language using platform.uiLanguage in UIAppMain during initialization of application settings:
---
platform.uiLanguage = "en";
---

Copyright: Vadim Lopatin 2014-2017, dayllenger 2018
License:   Boost License 1.0
Authors:   dayllenger
*/
module beamui.core.i18n;

import mofile;
import beamui.core.functions;
import beamui.core.logger;
import beamui.core.resources;

/** Translate a message into current application language.

    Params:
     original = The original message to translate
    Returns: Translated message if a translation was found,
     original message otherwise
*/
dstring tr(string original)
{
    string translated = original;
    foreach (tr; translators)
    {
        translated = tr.gettext(original);
        if (translated !is original)
            break;
    }
    return translated.toUTF32;
}

/** Translate a singular or a plural form of the message by the number.

    Params:
        singular = The original message in singular form
        plural = The original message in plural form
        n = Number to calculate the plural form
    Returns: Translated string in plural form depending on number n.
    If translation does not exists, returns the original message
*/
dstring tr(string singular, string plural, int n)
{
    string def = n > 1 ? plural : singular;
    string translated = def;
    foreach (tr; translators)
    {
        translated = tr.ngettext(singular, plural, n);
        if (translated !is def)
            break;
    }
    return translated.toUTF32;
}

/// Load translations for language from .mo file
void loadTranslator(string lang)
{
    auto filename = resourceList.getPathByID(lang ~ ".mo");
    if (filename)
    {
        auto content = loadResourceBytes(filename);
        translators ~= new MoFile(cast(immutable void[])content);
    }
}

private MoFile*[] translators;
