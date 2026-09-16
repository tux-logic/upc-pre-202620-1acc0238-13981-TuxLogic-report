import re
import sys

def make_titles_bold(svg_path):
    with open(svg_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Pattern for node text content:
    # Inside <g class="node ..."> ... <g class="label" ...> <text ...> ... </text>
    # We want title tspans (before the technology tag line starting with '[') to have font-weight="bold"
    
    # In mermaid svg with htmlLabels: false:
    # <tspan class="text-outer-tspan row" ...><tspan ... font-weight="normal">Title Word</tspan>...</tspan>
    
    # Let's replace font-weight="normal" with font-weight="bold" for all text-inner-tspan inside the title rows
    # Title rows are the text-outer-tspan rows before the row containing '[' or technology sub-label.

    def process_node(match):
        node_group = match.group(0)
        
        # Split node into text-outer-tspan rows
        rows = re.split(r'(<tspan class="text-outer-tspan row"[^>]*>)', node_group)
        if len(rows) <= 1:
            return node_group
        
        new_node_group = rows[0]
        in_title = True
        
        for i in range(1, len(rows), 2):
            tag = rows[i]
            body = rows[i+1]
            
            # Check if this row contains technology tag like '['
            if '[' in body:
                in_title = False
            
            if in_title:
                # Replace font-weight="normal" with font-weight="bold"
                body = body.replace('font-weight="normal"', 'font-weight="bold"')
                body = body.replace("font-weight='normal'", "font-weight='bold'")
            
            new_node_group += tag + body
            
        return new_node_group

    # Find all node groups
    processed_content = re.sub(
        r'<g class="node [^"]*" id="[^"]*"[^>]*>.*?</g></g></g>',
        process_node,
        content,
        flags=re.DOTALL
    )

    with open(svg_path, 'w', encoding='utf-8') as f:
        f.write(processed_content)
    print(f"Successfully processed {svg_path}")

if __name__ == '__main__':
    target = sys.argv[1] if len(sys.argv) > 1 else 'assets/billing/billing-c4-component.svg'
    make_titles_bold(target)
