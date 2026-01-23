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
      {block name='hook_footer'}
        {hook h='displayFooter'}
      {/block}
    </div>

    <div class="{$footer}__main-bottom">
      <div class="{$footer}__copyright">
        {block name='copyright_link'}
          <a href="https://www.prestashop-project.org/" target="_blank" rel="noopener noreferrer nofollow">
            {l s='%copyright% %year% - Ecommerce software by %prestashop%' sprintf=['%prestashop%' => 'PrestaShop™', '%year%' => 'Y'|date, '%copyright%' => '©'] d='Shop.Theme.Global'}
          </a>
        {/block}
      </div>

      {block name='hook_footer_after'}
        {hook h='displayFooterAfter'}
      {/block}
    </div>
  </div>
</div>
