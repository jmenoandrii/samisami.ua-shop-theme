{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

{$componentName = 'footer__email-subscription'}

<div class="{$componentName} footer_block">
  <form class="{$componentName}__content" action="{$urls.current_url}#blockEmailSubscription_{$hookName}" method="post">
    <a href="{$urls.pages.index}" class="{$componentName}__content-logo">
      <img class="logo" src="/modules/ps_emailsubscription/views/img/logo-samisami-footer.svg" alt="">
    </a>

    <div class="{$componentName}__content-title">
      <p id="block-newsletter-label-{$hookName}" class="{$componentName}__content-title-label">{l s='Get our latest news and special sales' d='Shop.Theme.Global'}</p>
    </div>

    <div class="{$componentName}__content-inputs">
      <input
        name="email"
        type="email"
        class="form-control {$componentName}__content-input"
        value="{$value}"
        placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
        aria-labelledby="block-newsletter-label-{$hookName}"
        required
      >

      <input
        class="{$componentName}__content-btn"
        name="submitNewsletter"
        type="submit"
        value="{l s='Subscribe' d='Shop.Theme.Actions'}"
      >
    </div>

    <div class="{$componentName}__content-infos">
      {if $conditions}
        <p>{$conditions}</p>
      {/if}

      {if $msg}
        <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
          {$msg}
        </p>
      {/if}

      {hook h='displayNewsletterRegistration'}

      {if isset($id_module)}
        {hook h='displayGDPRConsent' id_module=$id_module}
      {/if}
    </div>

    <input type="hidden" name="blockHookName" value="{$hookName}" />
    <input type="hidden" name="action" value="0">
  </form>
</div>
