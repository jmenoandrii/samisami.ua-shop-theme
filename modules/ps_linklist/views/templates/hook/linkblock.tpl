{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{foreach $linkBlocks as $linkBlock}
  <div class="footer__block">

    <p class="footer__block-title d-none d-md-flex">{$linkBlock.title}</p>

    <div role="button" class="footer__block-toggle d-md-none collapsed" aria-expanded="false" data-bs-target="#footer_sub_menu_{$linkBlock.id}" data-bs-toggle="collapse">
      <span class="footer__block-title">{$linkBlock.title}</span>
      <i class="material-icons" aria-hidden="true">arrow_drop_down</i>
    </div>

    <ul id="footer__submenu_{$linkBlock.id}" class="footer__block-content footer__block-content-list collapse">
      {foreach $linkBlock.links as $link}
        <li>
          <a
              id="{$link.id}-{$linkBlock.id}"
              class="{$link.class}"
              href="{$link.url}"
              title="{$link.description}"
              {if !empty($link.target)} target="{$link.target}" {/if}
         >
            {$link.title}
          </a>
        </li>
      {/foreach}
    </ul>
  </div>
{/foreach}
