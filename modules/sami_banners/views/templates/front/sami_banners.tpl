{$homeBanners = 'home-banners'}

<section class="{$homeBanners}">
    <div class="container sami-container">
        {foreach from=$banners item=banner}
            <div class="{$homeBanners}__item {$homeBanners}__item-{$banner.display_mode}
                        {$homeBanners}__align-x-{$banner.text_position_x} 
                        {$homeBanners}__align-y-{$banner.text_position_y} 
                        {$homeBanners}__theme-{$banner.text_theme}"
                 style="{if $banner.background_type == 'color'}
                            background-color: {$banner.background_color};
                        {elseif $banner.background_image && $banner.display_mode != 'full'}
                            background-image: url('{$module_dir}views/img/{$banner.background_image}');
                        {/if}">
                {if $banner.display_mode == 'full'}
                    <img class="{$homeBanners}__full-image" src="{$module_dir}views/img/{$banner.background_image}">
                {/if}
                {if $banner.display_mode == 'full-overlay'}
                    <div class="{$homeBanners}__overlay"></div>
                {/if}
                <div class="{$homeBanners}__content">
                    <div class="{$homeBanners}__text-wrapper">
                        {if $banner.title}
                            <h4 class="{$homeBanners}__title">{$banner.title|escape:'html':'UTF-8'}</h4>
                        {/if}
                        
                        {if $banner.text}
                            <div class="{$homeBanners}__text">
                                {$banner.text|nl2br nofilter}
                            </div>
                        {/if}
                    </div>
                    
                    {if $banner.button_enabled && $banner.button_text && $banner.button_link}
                        <div class="{$homeBanners}__button-wrapper">
                            <a href="{$banner.button_link|escape:'html':'UTF-8'}" 
                                class="{$homeBanners}__button">
                                {$banner.button_text|escape:'html':'UTF-8'}
                            </a>
                        </div>
                    {/if}
                </div>
            </div>
        {/foreach}
    </div>
</section>