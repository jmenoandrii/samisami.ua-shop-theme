{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$footer = 'footer'}

<div class="{$footer}__main">
  <div class="{$footer}_container sami-container"> 
    <div class="{$footer}__main-top">
      {block name='hook_footer_before'}
        {hook h='displayFooterBefore'}
      {/block}
      <div class="{$footer}__main-middle">
      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
      </div>
    </div>

    <div class="{$footer}__main-bottom">
      <div class="{$footer}__copyright">
        <p class="{$footer}__copyright-text">
          {l s='%copyright% %year% - Ecommerce software by %prestashop%' sprintf=['%prestashop%' => 'PrestaShop™', '%year%' => 'Y'|date, '%copyright%' => '©'] d='Shop.Theme.Global'}
        </p>
      </div>

      {block name='hook_footer_after'}
        {hook h='displayFooterAfter'}
      {/block}
    </div>
  </div>
</div>
