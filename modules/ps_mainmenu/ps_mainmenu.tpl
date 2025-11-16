{$headerMegaMenuName = 'header-mega-menu'}

{function name="desktopMenu" nodes=[] depth=0 parent=null}
  {if $nodes|count}
    {foreach from=$nodes item=node}
      <div class="{$headerMegaMenuName}__section">
        <h3 class="{$headerMegaMenuName}__title">
          <a class="{$headerMegaMenuName}__title__link {if $urls.current_url === $node.url} active{/if}" href="{$node.url}" {if $node.open_in_new_window}target="_blank"{/if}>{$node.label}</a>
        </h3>

        {if $node.children|count}
          <ul class="{$headerMegaMenuName}__list">
            {foreach from=$node.children item=child}
              <li class="{$headerMegaMenuName}__list-item">
                <a href="{$child.url}" class="{$headerMegaMenuName}__list-item__link {if $urls.current_url === $child.url} active{/if}" {if $child.open_in_new_window}target="_blank"{/if}>
                  {$child.label}
                </a>
              </li>
            {/foreach}
          </ul>
        {/if}
      </div>
    {/foreach}
  {/if}
{/function}

{function name="mobileMenu" nodes=[] depth=0 parent=null}
  {$children = []}
  {if $nodes|count}
    <nav
      class="menu menu--mobile{if $depth === 0} menu--current js-menu-current{else} menu--child js-menu-child{/if}"
      {if $depth === 0}id="menu-mobile"{else}data-parent-title="{$parent.label}"{/if}
      {if $depth > 1}data-back-title="{$backTitle}" data-id="{$expandId}"{/if}
      data-depth="{$depth}"
    >
      <ul class="menu__list">
        {if $depth >= 1}
          <li class="main-menu__title h5">{$parent.label}</li>
        {/if}
        {foreach from=$nodes item=node}
          <li
            class="{$node.type}{if $node.current} current{/if}{if $node.children|count} menu--childrens{/if}"
            id="{$node.page_identifier}"
          >
            <a
              class="{if $depth>= 0}menu__link{/if}"
              href="{$node.url}"
              data-depth="{$depth}"
              {if $node.open_in_new_window}target="_blank"{/if}
            >
            {$node.label}
            </a>
            {if $node.children|count}
              {* Cannot use page identifier as we can have the same page several times *}
              {assign var=_expand_id value=10|mt_rand:100000}
              <span class="main-menu__toggle-child js-menu-open-child" data-target="{$_expand_id}">
                <span data-target="#top_sub_menu_{$_expand_id}">
                  <i class="material-icons rtl-flip">chevron_right</i>
                </span>
              </span>
            {/if}
          </li>
          {if $node.children|count}
            {$node.parent = $node}
            {$node.expandId = $_expand_id}
            {$children[] = $node}
          {/if}
        {/foreach}
      </ul>
    </nav>
    {foreach from=$children item=child}
      {mobileMenu
        nodes=$child.children
        depth=$child.children[0].depth
        parent=$child backTitle=$child.parent.label
        expandId=$child.expandId
      }
    {/foreach}
  {/if}
{/function}
  
<div class ="sami-container {$headerMegaMenuName}__container">
  {desktopMenu nodes=$menu.children}
</div>
