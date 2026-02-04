{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<div class="footer__block footer__contact">

  <p class="footer__block-title">{l s='Store information' d='Shop.Theme.Global'}</p>

  <div id="contact-infos" class="footer__block-content footer__contact-content">
    {if $contact_infos.phone}
      <div class="footer__contact-phone">
        <a href="tel:{$contact_infos.phone}">{$contact_infos.phone}</a>
      </div>
    {/if}

    {if $contact_infos.fax}
      <div class="footer__contact-phone">
        <a href="tel:{$contact_infos.fax}">{$contact_infos.fax}</a>
      </div>
    {/if}

    <p class="footer__contact-timetable-title">{l s='Timetable Title' d='Shop.Theme.Global'}</p>
    <p class="footer__contact-timetable">{l s='Timetable' d='Shop.Theme.Global'}</p>

    {if $contact_infos.email && $display_email}
      <div class="footer__contact-email">
        <i class="material-symbols-outlined search js-search-icon" aria-hidden="true">mail</i>
        {mailto address=$contact_infos.email encode="javascript"}
      </div>
    {/if}

  </div>
</div>
